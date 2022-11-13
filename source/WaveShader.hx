package;
import openfl.display.Shader;
import flixel.system.FlxAssets.FlxShader;
class WaveShader
{
  public var realShader(default, null):WaveReal = new WaveReal();
  public var aFloat(default, set):Float = 0;

  public function set_aFloat(bFloat:Float)
  {
    aFloat = bFloat;
    realShader.iTime.value[0] = aFloat;
    return aFloat;
  }
  public function new()
  {
    realShader.iTime.value = [0, 0, 0];
  }
}
    class WaveReal extends FlxShader{

    
    @:glFragmentSource('
        #pragma header
        vec2 uv = openfl_TextureCoordv.xy;
        vec2 fragCoord = openfl_TextureCoordv*openfl_TextureSize;
        vec2 iResolution = openfl_TextureSize;
        uniform float iTime;
        #define iChannel0 bitmap
        #define texture flixel_texture2D
        #define fragColor gl_FragColor
        #define mainImage main
        
        void mainImage( ) 
        {
        #define EPS 2.e-3
          vec2 uv = fragCoord.xy / iResolution.xy;
          uv.x = 1.-uv.x;
          vec2 uvx = uv+vec2(EPS,0.);
          vec2 uvy = uv+vec2(0.,EPS);
          
          vec2 ref = vec2(.5,.5);
          vec3 col0 = texture(iChannel0, ref).xyz;
          float lum0 = (col0.x+col0.y+col0.z)/3.;
          
          bool isin = (uv.x > .5+.5*sin(iTime));
          
          vec3 tex,texx,texy;
          vec2 grad; float g=1.;
          
          for (int i=0; i<30; i++) 
          {
            tex = texture(iChannel0, uv).xyz;
        
            if (isin)
            {
              uvx = uv+vec2(EPS,0.);
              uvy = uv+vec2(0.,EPS);	
            }
            texx = texture(iChannel0, uvx).xyz;
            texy = texture(iChannel0, uvy).xyz;
            grad  = vec2(texx.x-tex.x,texy.x-tex.x); 
        //		if (i==0) g = dot(grad,grad);
            
            uv    += EPS*grad;
            uvx.x += EPS*grad.x;
            uvy.y += EPS*grad.y;
          }
          
          vec3 col = texture(iChannel0, uv).xyz;
            vec3 m = vec3(.2,.1,.1);
          float lum = (col.x+col.y+col.z)/3.;
        #if 1
          g = 4.*dot(grad,grad);
          g = pow(max(0.,1.-g),30.);
          g = clamp(g,0.,1.);
        #endif
          col = g * col / pow(lum,.55);
          
          fragColor = vec4(col, 1.0);
        }
        
    ')

    public function new()
    {
        super();
    }
}