<a-scene>
    <a-assets>
        [+if isset($photodata['image']) && $photodata['image'] != ''+]<img id="scene01" src="/uploads/[+$photodata['image']+]">[+/if+]
    </a-assets>

    <a-sky src="#scene01"></a-sky>
</a-scene>
