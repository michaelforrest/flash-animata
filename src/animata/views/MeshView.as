package animata.views {
	import app.controllers.App;
	import animata.models.Face;
	import animata.models.Layer;

	import com.lbi.mvc.view.ViewBase;

	public class MeshView extends ViewBase {

		private var layer : Layer;
		private var firstTime : Boolean = true;

		//private PFont font;

		public function MeshView( layer : Layer) {
			this.layer = layer;
			
		}

	/*
	 * 	glColor3f(1.f, 1.f, 1.f);
		glEnable(GL_TEXTURE_2D);
		glBindTexture(GL_TEXTURE_2D, attachedTexture->getGlResource());

		for (unsigned int i = 0; i < faces->size(); i++)
		{
			Face *face = (*faces)[i];

			glColor4f(1.f, 1.f, 1.f, textureAlpha);
			glBegin(GL_TRIANGLES);
				glTexCoord2f(face->v[0]->texCoord.x, face->v[0]->texCoord.y);
				glVertex2f(face->v[0]->view.x, face->v[0]->view.y);
				glTexCoord2f(face->v[1]->texCoord.x, face->v[1]->texCoord.y);
				glVertex2f(face->v[1]->view.x, face->v[1]->view.y);
				glTexCoord2f(face->v[2]->texCoord.x, face->v[2]->texCoord.y);
				glVertex2f(face->v[2]->view.x, face->v[2]->view.y);
			glEnd();
			glColor3f(1.f, 1.f, 1.f);
		}

		glDisable(GL_TEXTURE_2D);
	 */
	}
}
