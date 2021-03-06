<!-- start tabs -->
  <div class="tab-container">
    <div class="tabs">
          <ul>
            <%
              import json
              json_kwds = json.dumps(w.kwds);
            %>
            % for key, value in w.tabs.items():
            <li>
            <%
              selected = ''
              if w.active_tab == key:
                  selected = 'selected'
            %>

            <script type="text/javascript">
              function ${key}_tab_selected(tab) {
                var widget_url = "/_w/" + '${value['widget_key']}';
                return tab_selected(tab, widget_url, "${w.base_url}${key}", "#tab_content_${w._uuid}", ${json_kwds|n});
              }
            </script>
            <a class="${selected}" href="${w.base_url}${key}" onMouseOver="set_tabs_hover(this, True)" onMouseOut="set_tabs_hover(this, False)" onClick='return ${key}_tab_selected(this);'>
                ${value['display_name']}
            </a>
            </li>
            % endfor
          </ul>
        <script type="text/javascript">
          //FIXME: this is just for prototyping, move to seperate .js file in future
          function set_tabs_hover(tab, is_hovering) {
              var tabs_div = $(tab).parents('.tabs');

              if (is_hovering)
                  tabs_div.addClass('hover');
              else
                  tabs_div.removeClass('hover');
          }

          function tab_selected(tab, widget_url, location_mask, content_container, kwds) {
             var $tab = $(tab);

             // set the tab to selected
             tabs = $tab.parents('.tabs');
             selected = tabs.find('.selected');
             selected.removeClass('selected');
             $tab.addClass('selected');

             // dynamically load the content
             return moksha.dynamic_goto(widget_url, kwds, content_container, location_mask);
          }
        </script>
    </div>
    <div id="tab_content_${w._uuid}">
        ${w.widget.display(args=w.args, kwds=w.kwds) | n }
    <div>
  </div>
<!-- end tabs -->
