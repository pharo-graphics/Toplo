Class {
	#name : #ToToggleMenuItemSkin,
	#superclass : #ToMenuItemElementSkin,
	#category : #'Toplo-Widget-Menu-Items'
}

{ #category : #'event handling' }
ToToggleMenuItemSkin >> checkedSkinEvent: anEvent [

	super checkedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e background: (e valueOfTokenNamed: #'color-primary-checked').
		e iconDo: [ :ic |
			ic innerImageColor:
				(e valueOfTokenNamed: #'text-color-primary-checked') ].
		e labelDo: [ :lab | 
			lab foreground:  
					 (e valueOfTokenNamed: #'text-color-primary-checked').
			lab applyStyle ] ]
]

{ #category : #'event handling' }
ToToggleMenuItemSkin >> disabledSkinEvent: anEvent [

	super disabledSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e iconDo: [ :ic |
			ic innerImageColor: (e valueOfTokenNamed: #'color-text-disabled') ].
		e endElementDo: [ :ic |
			(ic respondsTo: #innerImageColor:) ifTrue: [
				ic innerImageColor: (e valueOfTokenNamed: #'color-text-disabled') ] ].
		e background: (e valueOfTokenNamed: #'color-bg-container-disabled').
		e labelDo: [ :lab |
			lab foreground: (e valueOfTokenNamed: #'color-text-disabled').
			lab applyStyle ] ]
]

{ #category : #'event handling' }
ToToggleMenuItemSkin >> enabledSkinEvent: anEvent [

	super enabledSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e iconDo: [ :ic |
			ic innerImageColor: (e valueOfTokenNamed: #'color-text') ].
		e endElementDo: [ :ic |
			(ic respondsTo: #innerImageColor:) ifTrue: [
				ic innerImageColor: (e valueOfTokenNamed: #'color-text') ] ].
		e background: BlBackground transparent .
		e labelDo: [ :lab |
			lab foreground: (e valueOfTokenNamed: #'color-text').
			lab applyStyle ] ]
]

{ #category : #'event handling' }
ToToggleMenuItemSkin >> indeterminateSkinEvent: anEvent [

	super indeterminateSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e background: (e valueOfTokenNamed: #'color-primary-indeterminate').
		e iconDo: [ :ic |
			ic innerImageColor: (e valueOfTokenNamed: #'color-text') ].
		e labelDo: [ :lab |
			lab foreground: (e valueOfTokenNamed: #'color-text').
			lab applyStyle ] ]
]

{ #category : #'event handling' }
ToToggleMenuItemSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e | 
		e startAlignment: (e valueOfTokenNamed: #'menu-item-start-alignment') ].

	
]

{ #category : #'event handling' }
ToToggleMenuItemSkin >> uncheckedSkinEvent: anEvent [

	super uncheckedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e background: BlBackground transparent.
		e iconDo: [ :ic |
			ic innerImageColor: (e valueOfTokenNamed: #'color-text') ].
		e labelDo: [ :lab |
			lab foreground: (e valueOfTokenNamed: #'color-text').
			lab applyStyle ] ]
]
