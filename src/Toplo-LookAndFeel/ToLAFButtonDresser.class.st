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
	
	anElement geometry: self skin builtGeometry.
	self background: self skin background in: anElement.
	self border: self skin border in: anElement.
]

{ #category : #'events handling' }
ToLAFButtonDresser >> leaved: anElement [

	

]

{ #category : #'api - install/uninstall  hook' }
ToLAFButtonDresser >> onInstalledIn: anElement [

	skin := anElement skin.
	self skin theme: anElement toTheme.
	
	self skin labelSkinType ifNotNil:[ :labelSkinType |
		anElement label ifNil:[ anElement label: ToLabel new ].
		anElement label skinType: labelSkinType.
	].
	
	super onInstalledIn: anElement.
]

{ #category : #'api - install/uninstall  hook' }
ToLAFButtonDresser >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement.
	skin := nil
]

{ #category : #accessing }
ToLAFButtonDresser >> skin [

	^ skin ifNil: [ skin := self defaultSkin ]
]
