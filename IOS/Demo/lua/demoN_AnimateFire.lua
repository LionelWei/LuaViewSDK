
scrW, scrH = System.screenSize();

window.frame(0, 0, scrW, scrH);
window.backgroundColor(0xffffff,1);
window.enabled(true);



local percent = 1;
local r = 40*percent;

local bodyX0 = scrW/2;
local bodyY0 = scrH/2;

lazhuBody = Image();
lazhuBody.frame( bodyX0 - 64*0.45, bodyY0 + r*0.5, 64, 104);
lazhuBody.image("lazhu.png");


-------------------------------
function fireCreater() 
	local fire = {};
	fire.times = 0;

	fire.imageView1 = Image();
	fire.imageView2 = Image();
	fire.imageView1.image("color1.png");
	fire.imageView2.image("color2.png");
	fire.imageView1.frame(0,0,r*2,r*2);
	fire.imageView2.frame(0,0,r*2,r*2);

	fire.bg = View();
	fire.bg.frame(0,0,r*2,r*2);
	fire.bg.addView(fire.imageView1);
	fire.bg.addView(fire.imageView2);

	function fire.initX0Y0()
		self.bg.scale(1, 1);
		self.bg.size( r*2, r*2);
		self.bg.alpha( 0.5);

		local x0 = math:random(bodyX0, bodyX0 + r*0.1);
		local y0 = math:random(bodyY0, bodyY0 + r*0.3);

		self.bg.center(x0,y0);
		self.x = x0;
		self.y = y0;

		self.imageView1.alpha( 1);
		self.imageView2.alpha( 0);
	end

	function fire.move() 
		self.bg.center( self.x, self.y );
		self.bg.scale( 0.2, 0.4 );
		self.imageView1.alpha(0);
		self.imageView2.alpha(1);
		self.bg.alpha(0);
	end

	function fire.nextXYAndColor() 
		local len = 30*percent;
		local dx = math:random(-len,len);
		local maxDy = math:sqrt( (len*len*2 - dx*dx) )*2;
		local dy = math:random( -maxDy, 0 );
		local x,y = self.bg.center();
		self.x = x+dx;
		self.y = y+dy;
	end

	function fire.showfires() 
		self.initX0Y0();
		self.nextXYAndColor();

		local time = math:random(15,20)/10.0;
		Animate(time,
			function ()
				self.move();
			end
			,
			function ()
				self.showfires();
			end
			);
	end

	return fire;
end
-------------------------------------
fireArr = {};

index = 1;
fireTimer = Timer(
	function()
		if (index<20 ) then
			index = index+1;
		   	fireArr[index] = fireCreater();
			fireArr[index].showfires();
		else
			fireTimer.cancel();
		end
	end
);

fireTimer.start(0.1, true);


