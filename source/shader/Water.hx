package shader;
import flixel.system.FlxAssets.FlxShader;
class Water extends FlxShader {
	@:glFragmentSource('
        #pragma header

        uniform float waves;
        uniform float uTime;

        void main()
        {
            //Calculate the size of a pixel (normalized)
            vec2 pixel = vec2(1.0,1.0) / openfl_TextureSize;
			
            //Grab the current position (normalized)
            vec2 p = openfl_TextureCoordv;
            
            //Create the effect using sine waves
            p.x += sin( p.y*waves+uTime*2.0 )*pixel.x;
            
            //Apply
            vec4 source = texture2D(bitmap, p);
            gl_FragColor = source;

        }'
    )
	public function new(Waves:Float)
    {
        super();
        this.waves.value = [Waves];
    }
}