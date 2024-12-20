Class {
	#name : #ToLabelEditorWindow,
	#superclass : #ToAnchoredWindow,
	#category : #'Toplo-Widget-Album-LabelEditor'
}

{ #category : #accessing }
ToLabelEditorWindow >> closedEventClass [ 

	^ ToLabelEditorWindowClosedEvent 
]

{ #category : #accessing }
ToLabelEditorWindow >> defaultElevation [

	^ BlRelativeElevation elevation: (SmallInteger maxVal - 200)
]

{ #category : #skin }
ToLabelEditorWindow >> installRawStyle [ 

	super installRawStyle.
	self border: BlBorder empty.

]

{ #category : #'api - displaying' }
ToLabelEditorWindow >> onPositionChangedToFitAnchorRootDo: aBlock [

	aBlock value
]

{ #category : #accessing }
ToLabelEditorWindow >> openedEventClass [ 

	^ ToLabelEditorWindowOpenedEvent 
]
