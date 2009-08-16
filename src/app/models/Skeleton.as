package app.models {

	public class Skeleton {

		
		public var joints : Array;
		public var bones : Array;
		private var mesh : Mesh;

		private static var allBones : Array = [];

		public function Skeleton( child : XMLList,  mesh : Mesh) {
			this.mesh = mesh;
			addJoints(child.joints.joint);
			addBones(child.bones.bone);
		}
		

		private function addBones(children : XMLList) : void {
			bones = [];
			for (var i : int = 0;i < children.length(); i++) {
				var element : XML = children[i];
			
				var bone : Bone = new Bone(element, joints, mesh);
				bones.push(bone);
				allBones.push(bone);
			}
		}

		private function addJoints(children : XMLList) : void {
			joints = [];
			for (var i : int = 0;i < children.length(); i++) {
				var element : XML = children[i];
				var joint : Joint = new Joint(element);
				joints.push(joint);
			}
		}

		public function simulate( times : int) : void {
			for (var i : int = 0;i < times; i++) {
				simulateJoints();		
				simulateBones();
			}
		}

		private function simulateBones() : void {
			for (var i : int = 0;i < bones.length; i++) {
				var bone : Bone = bones[i];
				bone.simulate();
				bone.translateVertices();
			}
		}

		private function simulateJoints() : void {
			for (var i : int = 0;i < joints.length; i++) {
				var joint : Joint = joints[i];
				joint.simulate();
			}			
		}

		public function findBones(name : String) : Array {
			var  result : Array = new Array();
			for (var i : int = 0;i < bones.length; i++) {
				var bone : Bone = bones[i];
			}
			if(bone.name == name ) result.add(bone);
			if(result.size() == 0) trace("sorry, couldn't find a bone called " + name);
			return result;
		}

		public static function findAllBones(name : String ) : Array {
			var result : Array = [];
			for (var i : int = 0;i < allBones.length; i++) {
				var bone : Bone = allBones[i];
				if(bone.name == name) result.add(bone);
			}
			return result;
		}
	}
}
