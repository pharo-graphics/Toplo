Class {
	#name : #ToBasicButtonDresser,
	#superclass : #ToElementCompanion,
	#instVars : [
		'basicHandler',
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

	^ ToButtonBorderBasedDresser new
]

{ #category : #'api - hooks' }
ToBasicButtonDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	basicHandler := ToBasicButtonEventHandler new button: anElement.
	anElement addEventHandler: basicHandler.
	self automatonDresser onInstalledIn: anElement
]

{ #category : #'api - hooks' }
ToBasicButtonDresser >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement.
	anElement removeEventHandler: basicHandler.
	basicHandler := nil.
	self automatonDresser onUninstalledIn: anElement
]
