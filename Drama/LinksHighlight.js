// LinksHighlight.js
//
// Created By Shinren Pan <shinnren.pan@gmail.com> on 2015/11/21.
// Copyright (c) 2015年 Shinren Pan. All rights reserved.

/**
 *  用來 Highlight 特定的 html links
 */

var shouldHighLightLinks = %@;
var links = document.links;

for(i = 0; i < links.length; i++)
{
    link = links[i];
    href = link.href;

    if(shouldHighLightLinks.indexOf(href) != -1)
    {
        link.style.backgroundColor = "yellow";
    }
    else
    {
        link.style.backgroundColor = "";
    }
}