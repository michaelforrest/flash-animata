package app.models {
	import flash.system.System;

	public class Skeleton {


	public var joints : Array;
	public var bones : Array;
	private var mesh : Mesh;

	private static var allBones : Array=[];

	public function Skeleton( child : XML,  mesh : Mesh) {
		this.mesh = mesh;
		addJoints(child.getChildren("joints/joint"));
		addBones(child.getChildren("bones/bone"));
	}

	private function addBones(children : Array) {
		bones = [];
		for (var i : int = 0; i < children.length; i++) {
			var element : XML = children[i];
			
			var bone : Bone = new Bone(element,joints, mesh);
			bones.push( bone );
			allBones.push(bone);
		}
	}

	private function addJoints(children: Array) {
		joints = [];
		for (var i : int = 0; i < children.length; i++) {
			var element : XML = children[i];
				var joint : Joint = new Joint(element);
			joints.add( joint );
		}
	}

	public function simulate( times : int) {
		for (var i : int = 0; i < times; i++) {
			for (var i : int = 0; i < joints.length; i++) {
				var joint : Joint = joints[i];
				joint.simulate();
				
			}					
			for (var i : int = 0; i < bones.length; i++) {
				var bone : Bone = bones[i];
				bone.simulate();
				bone.translateVertices();
				
			}
		}

	}

	public function findBones(name : String)  : Array{
		var  result :Array = new Array();
			for (var i : int = 0; i < bones.length; i++) {
				var bone : Bone = bones[i];
				
			}
			if(bone.name == name ) result.add(bone);
		if(result.size() == 0) trace("sorry, couldn't find a bone called " + name);
		return result;
	}

	public static function findAllBones(name : String ) :Array {
			var result : Array = [];
			for (var i : int = 0; i < allBones.length; i++) {
				var bone : Bone = allBones[i];
				if(bone.name == name) result.add(bone);
			}
		return result;
	}
	}}
