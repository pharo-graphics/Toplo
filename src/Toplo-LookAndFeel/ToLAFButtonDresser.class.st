Class {
	#name : #ToLAFButtonDresser,
	#superclass : #ToAbstractButtonDresser,
	#instVars : [
		'skin'
	],
	#category : #'Toplo-LookAndFeel-Dressers'
}

{ #category : #accessing }
ToLAFButtonDresser >> defaultSkin [

	^ ToDefaultButtonSkin new
]

{ #category : #'events handling' }
ToLAFButtonDresser >> escaped: anElement [

	

]

{ #category : #'events handling' }
ToLAFButtonDresser >> initialState: anElement [ 

	super initialState: anElement.
	
	"Create background"
	self background: self skin background in: anElement
]

{ #category : #'events handling' }
ToLAFButtonDresser >> leaved: anElement [

	

]

{ #category : #'api - install/uninstall  hook' }
ToLAFButtonDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	skin := anElement skin.
	self skin theme: anElement toTheme.
]

{ #category : #accessing }
ToLAFButtonDresser >> skin [

	^ skin ifNil: [ skin := self defaultSkin ]
]
