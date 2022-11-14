Class {
	#name : #ToBasicButtonDresser,
	#superclass : #ToElementCompanion,
	#instVars : [
		'automatonDresser'
	],
	#category : #'Toplo-Widget-Buttons'
}

{ #category : #accessing }
ToBasicButtonDresser >> automatonDresser [

	^ automatonDresser ifNil: [ automatonDresser := self defaultStateDresser ]
]

{ #category : #accessing }
ToBasicButtonDresser >> automatonDresser: aButtonStateDresser [

	automatonDresser := aButtonStateDresser
]

{ #category : #'api - hooks' }
ToBasicButtonDresser >> defaultStateDresser [

	^ ToButtonBorderBasedStateDresser new
]

{ #category : #'api - hooks' }
ToBasicButtonDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	self automatonDresser onInstalledIn: anElement
]

{ #category : #'api - hooks' }
ToBasicButtonDresser >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement.
	self automatonDresser onUninstalledIn: anElement
]
