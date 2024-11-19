Class {
	#name : #ToCheckMenuItemSkin,
	#superclass : #ToMenuItemSkin,
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #'event handling' }
ToCheckMenuItemSkin >> checkedSkinEvent: anEvent [

	super checkedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e icon innerImage border: (BlBorder
				 paint: (e valueOfTokenNamed: #'color-primary-checked')
				 width: 5).
		e indeterminateBar background: Color transparent ]
]

{ #category : #'event handling' }
ToCheckMenuItemSkin >> disabledSkinEvent: anEvent [

	super disabledSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e icon innerImage border: (e valueOfTokenNamed: #'color-border-disabled').
		e icon border: (e valueOfTokenNamed: #'color-border-disabled').
		e indeterminateBar background: Color transparent ]
]

{ #category : #'event handling' }
ToCheckMenuItemSkin >> enabledSkinEvent: anEvent [

	super enabledSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e icon border: (e valueOfTokenNamed: #'color-border') ]
]

{ #category : #'event handling' }
ToCheckMenuItemSkin >> hoveredSkinEvent: anEvent [

	super hoveredSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e icon border:
			(BlBorder paint: (e valueOfTokenNamed: #'color-primary') width: 1) ]
]

{ #category : #accessing }
ToCheckMenuItemSkin >> iconGeometryIn: aCheckbox [

	^ BlRoundedRectangleGeometry cornerRadius: 4
]

{ #category : #'event handling' }
ToCheckMenuItemSkin >> indeterminateSkinEvent: anEvent [

	super indeterminateSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e icon innerImage border: (BlBorder paint: (e valueOfTokenNamed: #'color-primary') width: 0).
		e indeterminateBar background: (e valueOfTokenNamed: #'color-primary') ]
]

{ #category : #'event handling' }
ToCheckMenuItemSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e | 
		e iconImage: ((e valueOfTokenNamed: #'checkbox-image-builder') value).
		e icon geometry: (self iconGeometryIn: e).
		e button startAlignment: (e valueOfTokenNamed: #'menu-item-start-alignment').
		e icon border: (e valueOfTokenNamed: #'color-border') ].

	
]

{ #category : #'event handling' }
ToCheckMenuItemSkin >> leavedSkinEvent: anEvent [

	super leavedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e icon border: (e valueOfTokenNamed: #'color-border') ]
]

{ #category : #'event handling' }
ToCheckMenuItemSkin >> uncheckedSkinEvent: anEvent [

	super uncheckedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e icon innerImage border: (BlBorder paint: (e valueOfTokenNamed: #'color-primary') width: 0).
		e indeterminateBar background: Color transparent ]
]
