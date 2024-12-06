Class {
	#name : #ToLabelEditorWindow,
	#superclass : #ToAnchoredWindow,
	#category : #'Toplo-Widget-Album-Label'
}

{ #category : #accessing }
ToLabelEditorWindow >> closedEventClass [ 

	^ ToLabelEditorClosedEvent 
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

{ #category : #accessing }
ToLabelEditorWindow >> newClosedEvent [

	^ self closedEventClass new
		  window: self;
		  text: windowManager element text copy;
		  yourself
]

{ #category : #accessing }
ToLabelEditorWindow >> openedEventClass [ 

	^ ToLabelEditorOpenedEvent 
]
