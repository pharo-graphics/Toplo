Class {
	#name : #ToploPanelInsideEventEditorForPropertyWriter,
	#superclass : #ToploPanelInsideEventEditorAbstract,
	#category : #'Toplo-IDE-theme-editor'
}

{ #category : #layout }
ToploPanelInsideEventEditorForPropertyWriter >> defaultLayout [

	^ SpBoxLayout newVertical spacing: 4;
		  add: 'ToploPanelInsideEventEditorForPropertyWriter.';
		  yourself
]
