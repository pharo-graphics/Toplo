Class {
	#name : #ToToggleMenuItemSkin,
	#superclass : #ToMenuItemSkin,
	#category : #'Toplo-Widget-Menu-Items'
}

{ #category : #'event handling' }
ToToggleMenuItemSkin >> checkedSkinEvent: anEvent [

	super checkedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
			e
				addTokenNamed: #'color-text'
				withValue: (e valueOfTokenNamed: #'text-color-primary-checked').
			e background: (e valueOfTokenNamed: #'color-primary-checked').
			e iconDo: [ :ic |
					ic adaptToColor:
						(e valueOfTokenNamed: #'text-color-primary-checked') ] ]
]

{ #category : #'event handling' }
ToToggleMenuItemSkin >> disabledSkinEvent: anEvent [

	super disabledSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e background: (e valueOfTokenNamed: #'color-bg-container-disabled') ]
]

{ #category : #'event handling' }
ToToggleMenuItemSkin >> enabledSkinEvent: anEvent [

	super enabledSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e background: BlBackground transparent ]
]

{ #category : #'event handling' }
ToToggleMenuItemSkin >> indeterminateSkinEvent: anEvent [

	super indeterminateSkinEvent: anEvent.
	anEvent elementDo: [ :e |
			e background: (e valueOfTokenNamed: #'color-primary-indeterminate').
			e iconDo: [ :ic |
				ic adaptToColor: (e valueOfTokenNamed: #'color-text') ] ]
]

{ #category : #testing }
ToToggleMenuItemSkin >> isTogglable [

	^ true
]

{ #category : #'event handling' }
ToToggleMenuItemSkin >> uncheckedSkinEvent: anEvent [

	super uncheckedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e removeTokenNamed: #'color-text'.
		e labelDo: [ :lab | lab requestNewSkin ].
		e background: BlBackground transparent.
		e iconDo: [ :ic |
			ic adaptToColor: (e valueOfTokenNamed: #'color-text') ].]
]
