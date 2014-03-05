<html>
    <%def name="resources()">
        ${tmpl_context.moksha_global_resources() | n}
    </%def>
    <%def name="header()">
        <script src="${tg.url('/js/typeahead.min.js')}"></script>

        <div class="head" id="head-main">
            ${resources()}

       <div id="container">
       <div id="searchbar">
           <div class="container_24">
               <script type="text/javascript">
                   function do_search(form) {
                       moksha.goto(form.action + '/' + form.search['value']);
                       return False;
                   }
               </script>
               <form action="${tg.url('/s')}"
                     onSubmit="return do_search(this);">
                   <div class="grid_5" id="header-main">
		      <h1 style="font-size:large;">
                         <a href="${tg.url('/')}">
			    <span>Fedora</span> Packages
			 </a>
		      </h1>
                   </div>
                   <div class="grid_13">
                       <input type="text" name="search" class="searchbar" />
                   </div>
                   <div class="grid_2">
                       <input type="submit" value="Search" class="searchsubmit" />
                   </div>
               </form>
               <div class="clear"></div>
           </div>
       </div>
       </div>

       <script>
         function strip(html) {
           var tmp = document.createElement("div");
           tmp.innerHTML = html;
           return tmp.textContent || tmp.innerText || "";
         }

         // This is inlined because we need tg.url(...)
         // We could create a function that takes the result of tg.url('/') as
         // an arguemnt, and move this out into another file, but we only use it
         // here for now, so it doesn't seem worth it yet.
         $('.searchbar').typeahead([
           {
             name: 'test',
             template: function(datum) {
               return '<img src="' + datum['icon'] + '" height="50" width="50" style="vertical-align: middle; margin-right: 10px;" alt="' + datum['name'] + ' icon"' + '/> ' + datum['name'];
             },
             remote: {
               url: "${tg.url('/fcomm_connector/xapian/query/search_packages/%7B%22filters%22:%20%7B%22search%22:%22%QUERY%22%7D,%22rows_per_page%22:10,%22start_row%22:%200%7D')}",
               filter: function(resp) {
                 thing = [];
                 for (idx in resp['rows']) {
                   row = resp['rows'][idx];
                   // This is potentially client-side expensive, but might be worth it.
                   $("<link />", { rel: "prefetch", href: "${tg.url('/')}" + row['name'] }).appendTo('head');
                   datum = {
                     'name': strip(row['name']),
                     'value': strip(row['name']),
                     'icon': "${tg.url('/images/icons/')}" + row['icon'] + ".png"
                   };
                   thing.push(datum);
                 }
                 return thing;
               }
             }
           }]);
         $('.searchbar').on('typeahead:selected', function (object, datum) {
           window.location.href = "${tg.url('/')}" + datum['name'];
         });
      </script>
    </%def>
</html>
