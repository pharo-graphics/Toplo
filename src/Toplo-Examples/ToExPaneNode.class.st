"
I'm part of a larger example. I'm not expected to be opened as a standalone. 

Check `ToSandBox >> example_ListWithPanes`
"
Class {
	#name : #ToExPaneNode,
	#superclass : #ToPane,
	#category : #'Toplo-Examples-Parts'
}

{ #category : #skin }
ToExPaneNode >> newRawSkin [ 

	^ ToPaneNodeExampleSkin new
]
