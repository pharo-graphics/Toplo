Class {
	#name : #ToBasicButtonDresser,
	#superclass : #ToElementCompanion,
	#instVars : [
		'stateDresser'
	],
	#category : #'Toplo-Widget-Buttons'
}

{ #category : #'api - hooks' }
ToBasicButtonDresser >> defaultStateDresser [

	^ ToButtonBorderBasedStateDresser new
]

{ #category : #'api - hooks' }
ToBasicButtonDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	self stateDresser onInstalledIn: anElement
]

{ #category : #accessing }
ToBasicButtonDresser >> stateDresser [

	^ stateDresser ifNil: [ stateDresser := self defaultStateDresser ]
]

{ #category : #accessing }
ToBasicButtonDresser >> stateDresser: aButtonStateDresser [

	stateDresser := aButtonStateDresser
]
