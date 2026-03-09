Class {
	#name : #ToLabelEditorWindow,
	#superclass : #ToAnchoredWindow,
	#category : #'Toplo-Widget-Album'
}

{ #category : #accessing }
ToLabelEditorWindow >> closedEventClass [ 

	^ ToLabelEditorWindowClosedEvent 
]

{ #category : #accessing }
ToLabelEditorWindow >> defaultElevation [

	^ BlRelativeElevation elevation: (SmallInteger maxVal - 200)
]

{ #category : #accessing }
ToLabelEditorWindow >> openedEventClass [ 

	^ ToLabelEditorWindowOpenedEvent 
]
