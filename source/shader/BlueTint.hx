package shader;
import flixel.system.FlxAssets.FlxShader;

class BlueTint extends FlxShader {
	@:glFragmentSource('
        #pragma header

        uniform float power;

        void main()
        {
        	
        	vec4 source = texture2D(bitmap, openfl_TextureCoordv);
            gl_FragColor = source;

            gl_FragColor.r = gl_FragColor.r/power;
    		gl_FragColor.g = gl_FragColor.g/power;


        }'
    )
	public function new()
    {
        super();

        this.power.value = [2.0];
        
    }
	
}