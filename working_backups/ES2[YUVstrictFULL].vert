<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  
  

  


  <head>
    <title>
      ES2[YUVstrictFULL].vert on ES2shaders – Attachment
     – gpac
    </title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <!--[if IE]><script type="text/javascript">
      if (/^#__msie303:/.test(window.location.hash))
        window.location.replace(window.location.hash.replace(/^#__msie303:/, '#'));
    </script><![endif]-->
        <link rel="search" href="/trac/project/gpac/search" />
        <link rel="help" href="/trac/project/gpac/wiki/TracGuide" />
        <link rel="alternate" href="/trac/project/gpac/raw-attachment/wiki/ES2shaders/ES2%5BYUVstrictFULL%5D.vert" title="Original format" />
        <link rel="up" href="/trac/project/gpac/wiki/ES2shaders" title="ES2shaders" />
        <link rel="start" href="/trac/project/gpac/wiki" />
        <link rel="stylesheet" href="/trac/project/gpac/chrome/common/css/trac.css" type="text/css" /><link rel="stylesheet" href="/trac/project/gpac/pygments/trac.css" type="text/css" /><link rel="stylesheet" href="/trac/project/gpac/chrome/common/css/code.css" type="text/css" /><link rel="stylesheet" href="/trac/project/gpac/chrome/listofwikipages/style.css" type="text/css" />
        <link rel="shortcut icon" href="/trac-htdocs/project/gpac/favicon.ico" type="image/x-icon" />
        <link rel="icon" href="/trac-htdocs/project/gpac/favicon.ico" type="image/x-icon" />
      <link type="application/opensearchdescription+xml" rel="search" href="/trac/project/gpac/search/opensearch" title="Search gpac" />
    <script type="text/javascript" src="/trac/project/gpac/chrome/common/js/jquery.js"></script><script type="text/javascript" src="/trac/project/gpac/chrome/common/js/babel.js"></script><script type="text/javascript" src="/trac/project/gpac/chrome/common/js/messages/en_GB.js"></script><script type="text/javascript" src="/trac/project/gpac/chrome/common/js/trac.js"></script><script type="text/javascript" src="/trac/project/gpac/chrome/common/js/search.js"></script>
    <!--[if lt IE 7]>
    <script type="text/javascript" src="/trac/project/gpac/chrome/common/js/ie_pre7_hacks.js"></script>
    <![endif]-->
      <script type="text/javascript" src="/trac/project/gpac/chrome/common/js/folding.js"></script>
      <script type="text/javascript">
        jQuery(document).ready(function($) {
          $('#preview table.code').enableCollapsibleColumns($('#preview table.code thead th.content'));
        });
      </script>
  </head>
  <body>
    <div id="banner">
      <div id="header">
        <a id="logo" href="http://www.telecom-paristech.fr"><img src="/trac-htdocs/project/gpac/trac_header_logo.png" alt="Telecom ParisTech" /></a>
      </div>
      <form id="search" action="/trac/project/gpac/search" method="get">
        <div>
          <label for="proj-search">Search:</label>
          <input type="text" id="proj-search" name="q" size="18" value="" />
          <input type="submit" value="Search" />
        </div>
      </form>
      <div id="metanav" class="nav">
    <ul>
      <li class="first">logged in as potetsia</li><li><a href="/trac/project/gpac/logout">Logout</a></li><li><a href="/trac/project/gpac/prefs">Preferences</a></li><li><a href="/trac/project/gpac/wiki/TracGuide">Help/Guide</a></li><li class="last"><a href="/trac/project/gpac/about">About Trac</a></li>
    </ul>
  </div>
    </div>
    <div id="mainnav" class="nav">
    <ul>
      <li class="first"><a href="/trac/project/gpac/blog">Blog</a></li><li class="active"><a href="/trac/project/gpac/wiki">Wiki</a></li><li><a href="/trac/project/gpac/discussion">Discussion</a></li><li><a href="/trac/project/gpac/browser">Browse source</a></li><li><a href="/trac/project/gpac/report">View tickets</a></li><li><a href="/trac/project/gpac/newticket">New ticket</a></li><li><a href="/trac/project/gpac/timeline">Timeline</a></li><li><a href="/trac/project/gpac/search">Search</a></li><li class="last"><a href="/trac/project/gpac/admin" title="Administration">Admin</a></li>
    </ul>
  </div>
    <div id="main">
      <div id="ctxtnav" class="nav">
        <h2>Context navigation</h2>
          <ul>
              <li class="last first"><a href="/trac/project/gpac/wiki/ES2shaders">Back to ES2shaders</a></li>
          </ul>
        <hr />
      </div>
    <div id="content" class="attachment">
        <h1><a href="/trac/project/gpac/wiki/ES2shaders">ES2shaders</a>: ES2[YUVstrictFULL].vert</h1>
        <table id="info" summary="Description">
          <tbody>
            <tr>
              <th scope="col">File ES2[YUVstrictFULL].vert,
                <span title="3906 bytes">3.8 KB</span>
                (added by potetsia, <a class="timeline" href="/trac/project/gpac/timeline?from=2015-01-30T15%3A32%3A56%2B01%3A00&amp;precision=second" title="2015-01-30T15:32:56+01:00 in Timeline">3 hours</a> ago)</th>
            </tr>
            <tr>
              <td class="message searchable">
                <p>
+ mat2d
</p>

              </td>
            </tr>
          </tbody>
        </table>
        <div id="preview" class="searchable">
          
  <table class="code"><thead><tr><th class="lineno" title="Line numbers">Line</th><th class="content"> </th></tr></thead><tbody><tr><th id="L1"><a href="#L1">1</a></th><td>/**</td></tr><tr><th id="L2"><a href="#L2">2</a></th><td> * Shader implementing: Clipping, Texturing, Lighting, Fog</td></tr><tr><th id="L3"><a href="#L3">3</a></th><td> * does NOT implement: mat2d</td></tr><tr><th id="L4"><a href="#L4">4</a></th><td> * TODO:        background</td></tr><tr><th id="L5"><a href="#L5">5</a></th><td> *                      material with/without lighting</td></tr><tr><th id="L6"><a href="#L6">6</a></th><td> *</td></tr><tr><th id="L7"><a href="#L7">7</a></th><td> **/</td></tr><tr><th id="L8"><a href="#L8">8</a></th><td></td></tr><tr><th id="L9"><a href="#L9">9</a></th><td>#pragma STDGL invariant(all)    //delete after testing</td></tr><tr><th id="L10"><a href="#L10">10</a></th><td></td></tr><tr><th id="L11"><a href="#L11">11</a></th><td>#define FOG_TYPE_LINEAR 0</td></tr><tr><th id="L12"><a href="#L12">12</a></th><td>#define FOG_TYPE_EXP    1</td></tr><tr><th id="L13"><a href="#L13">13</a></th><td>#define FOG_TYPE_EXP2   2</td></tr><tr><th id="L14"><a href="#L14">14</a></th><td></td></tr><tr><th id="L15"><a href="#L15">15</a></th><td>#define L_DIRECTIONAL   0</td></tr><tr><th id="L16"><a href="#L16">16</a></th><td>#define L_SPOT              1</td></tr><tr><th id="L17"><a href="#L17">17</a></th><td>#define L_POINT                 2</td></tr><tr><th id="L18"><a href="#L18">18</a></th><td></td></tr><tr><th id="L19"><a href="#L19">19</a></th><td>#define LIGHTS_MAX              8</td></tr><tr><th id="L20"><a href="#L20">20</a></th><td>#define TEXTURES_MAX    2</td></tr><tr><th id="L21"><a href="#L21">21</a></th><td></td></tr><tr><th id="L22"><a href="#L22">22</a></th><td>#define CLIPS_MAX               8</td></tr><tr><th id="L23"><a href="#L23">23</a></th><td></td></tr><tr><th id="L24"><a href="#L24">24</a></th><td>struct gfLight{</td></tr><tr><th id="L25"><a href="#L25">25</a></th><td>        int type;</td></tr><tr><th id="L26"><a href="#L26">26</a></th><td>        vec4 position;</td></tr><tr><th id="L27"><a href="#L27">27</a></th><td>        vec4 direction;</td></tr><tr><th id="L28"><a href="#L28">28</a></th><td>        vec3 attenuation;</td></tr><tr><th id="L29"><a href="#L29">29</a></th><td>        vec4 color;</td></tr><tr><th id="L30"><a href="#L30">30</a></th><td>        float ambientIntensity;</td></tr><tr><th id="L31"><a href="#L31">31</a></th><td>        float intensity;        //Diffuse</td></tr><tr><th id="L32"><a href="#L32">32</a></th><td>        float beamWidth;</td></tr><tr><th id="L33"><a href="#L33">33</a></th><td>        float cutOffAngle;</td></tr><tr><th id="L34"><a href="#L34">34</a></th><td>};</td></tr><tr><th id="L35"><a href="#L35">35</a></th><td></td></tr><tr><th id="L36"><a href="#L36">36</a></th><td>//attributes</td></tr><tr><th id="L37"><a href="#L37">37</a></th><td>        attribute vec4 gfVertex;</td></tr><tr><th id="L38"><a href="#L38">38</a></th><td>        attribute vec3 gfNormal;</td></tr><tr><th id="L39"><a href="#L39">39</a></th><td>        attribute vec4 gfMultiTexCoord;</td></tr><tr><th id="L40"><a href="#L40">40</a></th><td>        attribute vec4 gfMeshColor;</td></tr><tr><th id="L41"><a href="#L41">41</a></th><td>        </td></tr><tr><th id="L42"><a href="#L42">42</a></th><td>//fog unifrosm</td></tr><tr><th id="L43"><a href="#L43">43</a></th><td>        uniform bool gfFogEnabled; </td></tr><tr><th id="L44"><a href="#L44">44</a></th><td>        uniform vec3 gfFogColor; </td></tr><tr><th id="L45"><a href="#L45">45</a></th><td>        uniform float gfFogDensity; </td></tr><tr><th id="L46"><a href="#L46">46</a></th><td>        uniform int gfFogType; </td></tr><tr><th id="L47"><a href="#L47">47</a></th><td>        uniform float gfFogVisibility; </td></tr><tr><th id="L48"><a href="#L48">48</a></th><td>        </td></tr><tr><th id="L49"><a href="#L49">49</a></th><td>        </td></tr><tr><th id="L50"><a href="#L50">50</a></th><td></td></tr><tr><th id="L51"><a href="#L51">51</a></th><td>        uniform vec4 gfLightDiffuse; </td></tr><tr><th id="L52"><a href="#L52">52</a></th><td>        uniform vec4 gfDiffuseColor; </td></tr><tr><th id="L53"><a href="#L53">53</a></th><td>        uniform vec4 gfLightAmbient; </td></tr><tr><th id="L54"><a href="#L54">54</a></th><td>        uniform int gfNumTextures;</td></tr><tr><th id="L55"><a href="#L55">55</a></th><td>        uniform mat4 gfModelViewMatrix;</td></tr><tr><th id="L56"><a href="#L56">56</a></th><td>        uniform mat4 gfProjectionMatrix; </td></tr><tr><th id="L57"><a href="#L57">57</a></th><td>        uniform mat4 gfNormalMatrix; </td></tr><tr><th id="L58"><a href="#L58">58</a></th><td>        uniform vec4 gfEmissionColor; </td></tr><tr><th id="L59"><a href="#L59">59</a></th><td>    uniform vec4 gfAmbientColor;</td></tr><tr><th id="L60"><a href="#L60">60</a></th><td>        uniform int gfNumLights;</td></tr><tr><th id="L61"><a href="#L61">61</a></th><td>    uniform vec4 gfLightPosition; </td></tr><tr><th id="L62"><a href="#L62">62</a></th><td>    uniform vec4 gfLightAmbiant;</td></tr><tr><th id="L63"><a href="#L63">63</a></th><td>        uniform mat4 gfTextureMatrix;</td></tr><tr><th id="L64"><a href="#L64">64</a></th><td>        uniform gfLight lights[LIGHTS_MAX];</td></tr><tr><th id="L65"><a href="#L65">65</a></th><td>        uniform vec4 clipPlane[CLIPS_MAX];      //we can put these two in a struct</td></tr><tr><th id="L66"><a href="#L66">66</a></th><td>        uniform bool clipActive[CLIPS_MAX];</td></tr><tr><th id="L67"><a href="#L67">67</a></th><td>        uniform bool hasClip;</td></tr><tr><th id="L68"><a href="#L68">68</a></th><td>        uniform bool hasMeshColor;      //MESH_HAS_COLOR replaces the diffuse colour value of the material</td></tr><tr><th id="L69"><a href="#L69">69</a></th><td>        uniform bool enableLights;</td></tr><tr><th id="L70"><a href="#L70">70</a></th><td></td></tr><tr><th id="L71"><a href="#L71">71</a></th><td>        varying vec3 n;</td></tr><tr><th id="L72"><a href="#L72">72</a></th><td>        varying vec4 gfEye;</td></tr><tr><th id="L73"><a href="#L73">73</a></th><td>        //varying vec3 lightVector;</td></tr><tr><th id="L74"><a href="#L74">74</a></th><td>        //varying vec3 halfVector;</td></tr><tr><th id="L75"><a href="#L75">75</a></th><td>        varying vec2 TexCoord;</td></tr><tr><th id="L76"><a href="#L76">76</a></th><td>        varying float clipDistance[CLIPS_MAX];</td></tr><tr><th id="L77"><a href="#L77">77</a></th><td>        varying vec3 lightVector[8];</td></tr><tr><th id="L78"><a href="#L78">78</a></th><td>        varying vec3 halfVector[8];</td></tr><tr><th id="L79"><a href="#L79">79</a></th><td>        varying float gfFogFactor;</td></tr><tr><th id="L80"><a href="#L80">80</a></th><td>        </td></tr><tr><th id="L81"><a href="#L81">81</a></th><td>        //testing material</td></tr><tr><th id="L82"><a href="#L82">82</a></th><td>        varying vec4 m_ambientC;</td></tr><tr><th id="L83"><a href="#L83">83</a></th><td>        varying vec4 m_diffuseC;</td></tr><tr><th id="L84"><a href="#L84">84</a></th><td>        varying vec4 m_specularC;</td></tr><tr><th id="L85"><a href="#L85">85</a></th><td>        varying vec4 m_emissionC;</td></tr><tr><th id="L86"><a href="#L86">86</a></th><td>        varying float m_shininess;      //a.ka. specular exponent</td></tr><tr><th id="L87"><a href="#L87">87</a></th><td>        varying vec4 m_color;</td></tr><tr><th id="L88"><a href="#L88">88</a></th><td>//+ uniform bool hasMeshColour;</td></tr><tr><th id="L89"><a href="#L89">89</a></th><td>        </td></tr><tr><th id="L90"><a href="#L90">90</a></th><td>        </td></tr><tr><th id="L91"><a href="#L91">91</a></th><td>float fog() {</td></tr><tr><th id="L92"><a href="#L92">92</a></th><td></td></tr><tr><th id="L93"><a href="#L93">93</a></th><td>        float fog, eyeDist = length(gfEye-gfVertex);</td></tr><tr><th id="L94"><a href="#L94">94</a></th><td></td></tr><tr><th id="L95"><a href="#L95">95</a></th><td>        if(gfFogType==FOG_TYPE_LINEAR){</td></tr><tr><th id="L96"><a href="#L96">96</a></th><td>                fog= (gfFogVisibility-eyeDist)/gfFogVisibility;</td></tr><tr><th id="L97"><a href="#L97">97</a></th><td>        }else if(gfFogType==FOG_TYPE_EXP){</td></tr><tr><th id="L98"><a href="#L98">98</a></th><td>                fog= exp(-(gfEye.z * gfFogDensity));</td></tr><tr><th id="L99"><a href="#L99">99</a></th><td>        }else if(gfFogType==FOG_TYPE_EXP2){</td></tr><tr><th id="L100"><a href="#L100">100</a></th><td>                fog= (gfEye.z * gfFogDensity);</td></tr><tr><th id="L101"><a href="#L101">101</a></th><td>                fog = exp(-(fog * fog));</td></tr><tr><th id="L102"><a href="#L102">102</a></th><td>        }</td></tr><tr><th id="L103"><a href="#L103">103</a></th><td>        return clamp(fog, 0.0, 1.0);</td></tr><tr><th id="L104"><a href="#L104">104</a></th><td>}</td></tr><tr><th id="L105"><a href="#L105">105</a></th><td>        </td></tr><tr><th id="L106"><a href="#L106">106</a></th><td>        </td></tr><tr><th id="L107"><a href="#L107">107</a></th><td>        </td></tr><tr><th id="L108"><a href="#L108">108</a></th><td>        </td></tr><tr><th id="L109"><a href="#L109">109</a></th><td>        </td></tr><tr><th id="L110"><a href="#L110">110</a></th><td>        </td></tr><tr><th id="L111"><a href="#L111">111</a></th><td>        </td></tr><tr><th id="L112"><a href="#L112">112</a></th><td>        void main(void)</td></tr><tr><th id="L113"><a href="#L113">113</a></th><td>        {</td></tr><tr><th id="L114"><a href="#L114">114</a></th><td>        </td></tr><tr><th id="L115"><a href="#L115">115</a></th><td>                gfEye = gfModelViewMatrix * gfVertex;</td></tr><tr><th id="L116"><a href="#L116">116</a></th><td>        </td></tr><tr><th id="L117"><a href="#L117">117</a></th><td>                n = normalize( vec3(gfNormalMatrix * vec4(gfNormal, 0.0)) );</td></tr><tr><th id="L118"><a href="#L118">118</a></th><td>                //alternative to normal</td></tr><tr><th id="L119"><a href="#L119">119</a></th><td>                /*</td></tr><tr><th id="L120"><a href="#L120">120</a></th><td>                mat3 normM;</td></tr><tr><th id="L121"><a href="#L121">121</a></th><td>                normM[0] = gfNormalMatrix[0].xyz;</td></tr><tr><th id="L122"><a href="#L122">122</a></th><td>                normM[1] = gfNormalMatrix[1].xyz;</td></tr><tr><th id="L123"><a href="#L123">123</a></th><td>                normM[2] = gfNormalMatrix[2].xyz;</td></tr><tr><th id="L124"><a href="#L124">124</a></th><td>                n = normM * gfNormal;</td></tr><tr><th id="L125"><a href="#L125">125</a></th><td>                n = normalize(n);</td></tr><tr><th id="L126"><a href="#L126">126</a></th><td>                */</td></tr><tr><th id="L127"><a href="#L127">127</a></th><td>                </td></tr><tr><th id="L128"><a href="#L128">128</a></th><td>                if(hasMeshColor){</td></tr><tr><th id="L129"><a href="#L129">129</a></th><td>                        m_color = gfMeshColor;  //we use the m_color as a container for fragment parsing, since gfMeshColor is an attribute</td></tr><tr><th id="L130"><a href="#L130">130</a></th><td>                }</td></tr><tr><th id="L131"><a href="#L131">131</a></th><td>                </td></tr><tr><th id="L132"><a href="#L132">132</a></th><td>        if (gfNumLights &gt; 0) {</td></tr><tr><th id="L133"><a href="#L133">133</a></th><td>                for(int i=0; i&lt;LIGHTS_MAX; i++){</td></tr><tr><th id="L134"><a href="#L134">134</a></th><td>                        if(i&gt;=gfNumLights) break;</td></tr><tr><th id="L135"><a href="#L135">135</a></th><td></td></tr><tr><th id="L136"><a href="#L136">136</a></th><td>                        if ( lights[i].type == L_SPOT || lights[i].type == L_POINT ) {</td></tr><tr><th id="L137"><a href="#L137">137</a></th><td>                                lightVector[i] = lights[i].position.xyz - gfEye.xyz;    //do NOT do it here (dunno know why)</td></tr><tr><th id="L138"><a href="#L138">138</a></th><td>                        } else {</td></tr><tr><th id="L139"><a href="#L139">139</a></th><td>                        //if it is a directional light, position SHOULD indicate direction (modified implementation - check before commiting)</td></tr><tr><th id="L140"><a href="#L140">140</a></th><td>                                lightVector[i] = lights[i].direction.xyz;</td></tr><tr><th id="L141"><a href="#L141">141</a></th><td>                        }</td></tr><tr><th id="L142"><a href="#L142">142</a></th><td>                        halfVector[i] = lightVector[i] + gfEye.xyz; </td></tr><tr><th id="L143"><a href="#L143">143</a></th><td>                }</td></tr><tr><th id="L144"><a href="#L144">144</a></th><td>        }</td></tr><tr><th id="L145"><a href="#L145">145</a></th><td></td></tr><tr><th id="L146"><a href="#L146">146</a></th><td>        gfFogFactor = gfFogEnabled ? fog() : 1.0;</td></tr><tr><th id="L147"><a href="#L147">147</a></th><td></td></tr><tr><th id="L148"><a href="#L148">148</a></th><td></td></tr><tr><th id="L149"><a href="#L149">149</a></th><td>        if(gfNumTextures&gt;0)</td></tr><tr><th id="L150"><a href="#L150">150</a></th><td>                TexCoord = vec2(gfTextureMatrix * gfMultiTexCoord);</td></tr><tr><th id="L151"><a href="#L151">151</a></th><td></td></tr><tr><th id="L152"><a href="#L152">152</a></th><td>        if(hasClip){</td></tr><tr><th id="L153"><a href="#L153">153</a></th><td>                for(int i=0;i&lt;CLIPS_MAX;i++){</td></tr><tr><th id="L154"><a href="#L154">154</a></th><td>                                clipDistance[i] = clipActive[i] ? dot(gfVertex.xyz, clipPlane[i].xyz) + clipPlane[i].w : 1.0;</td></tr><tr><th id="L155"><a href="#L155">155</a></th><td>                        }</td></tr><tr><th id="L156"><a href="#L156">156</a></th><td>        }</td></tr><tr><th id="L157"><a href="#L157">157</a></th><td></td></tr><tr><th id="L158"><a href="#L158">158</a></th><td>        gl_Position = gfProjectionMatrix * gfEye;</td></tr><tr><th id="L159"><a href="#L159">159</a></th><td></td></tr><tr><th id="L160"><a href="#L160">160</a></th><td>}</td></tr></tbody></table>

        </div>
    </div>
    <div id="altlinks">
      <h3>Download in other formats:</h3>
      <ul>
        <li class="last first">
          <a rel="nofollow" href="/trac/project/gpac/raw-attachment/wiki/ES2shaders/ES2%5BYUVstrictFULL%5D.vert">Original format</a>
        </li>
      </ul>
    </div>
    </div>
    <div id="footer" lang="en" xml:lang="en"><hr />
      <a id="tracpowered" href="http://trac.edgewall.org/"><img src="/trac/project/gpac/chrome/common/trac_logo_mini.png" height="30" width="107" alt="Trac Powered" /></a>
      <p class="left">Powered by <a href="/trac/project/gpac/about"><strong>Trac 0.12.5</strong></a><br />
        By <a href="http://www.edgewall.org/">Edgewall Software</a>.</p>
      <p class="right">© <a href="http://www.telecom-paristech.fr/">Télécom ParisTech</a></p>
    </div>
  </body>
</html>