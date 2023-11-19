Class {
	#name : #ToLabelEditorWindow,
	#superclass : #ToAnchoredWindow,
	#category : 'Toplo-Widget-Album-Label'
}

{ #category : #accessing }
ToLabelEditorWindow >> defaultElevation [

	^ BlRelativeElevation elevation: (SmallInteger maxVal - 200)
]
