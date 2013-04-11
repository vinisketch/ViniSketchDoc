function instrumentTree (node)
{
  function onclick (e)
  {
    var li = e.target;

    if (li.className === 'level1 collapse')
    { li.className = 'level1 expand'; }
    else
    { li.className = 'level1 collapse'; }
  }

  var lis = node.querySelectorAll ('.level1');
  for (var i = 0; i < lis.length; i++)
  {
    li = lis.item (i);
    li.onclick  = onclick;
  }
}

function initLinks ()
{
  console.log ('initLinks');
  loadData ("API Reference [en]", "API_b2/tree.html");
  loadData ("User Guide [jp]", "userguide_ja/tree.html");
  loadData ("Tutorials [jp]", "tutorial/tree.html");
  loadData ("Guidelines [fr/en]", "guidelines/tree.html");
//  loadData ("VSD Native plugins", "plugins/ext_tree.html");
}

function addLink (name, text)
{
  var index_tree = document.getElementById ('index_tree');
  var a = document.createElement ('a');
  a.className = 'section'
  a.innerHTML = name;
  a.href = "main.html";
  a.target = "vsd_classes";

  index_tree.appendChild (a);
  var div = document.createElement ('div');
  div.innerHTML = text;

  instrumentTree (div.firstElementChild);
  index_tree.appendChild (div.firstElementChild);
}


function loadData (name, url)
{
  var xhr = new XMLHttpRequest ();

  //prepare the xmlhttprequest object
  xhr.open ("GET", url, true);
  xhr.setRequestHeader ("Cache-Control", "no-cache");
  xhr.setRequestHeader ("Pragma", "no-cache");

  var self = this;
  xhr.onreadystatechange = function ()
  {
    if (xhr.readyState === 4)
    {
      addLink (name, xhr.responseText);
    }
  }

  //send the request
  xhr.send (null);
};
