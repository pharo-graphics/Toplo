"
I'm part of a larger example. I'm not expected to be opened as a standalone. 

Check `ToSandBox >> example_ListWithPanes`
"
Class {
	#name : #ToPaneNodeExamplePart,
	#superclass : #ToPane,
	#category : #'Toplo-Examples-Parts'
}

{ #category : #skin }
ToPaneNodeExamplePart >> newRawSkin [ 

	^ ToPaneNodeExampleSkin new
]
