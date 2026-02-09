Class {
	#name : #ToCheckboxSkin,
	#superclass : #ToButtonSkin,
	#category : #'Toplo-Widget-Button-Checkable'
}

{ #category : #'event handling' }
ToCheckboxSkin >> checkedSkinEvent: anEvent [

	super checkedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
			e icon
				innerImage: (e valueOfTokenNamed: #'checkbox-checked-image');
				innerImageColor: (e valueOfTokenNamed: #'checkbox-color') ]
]

{ #category : #'event handling' }
ToCheckboxSkin >> disabledSkinEvent: anEvent [

	super disabledSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e iconDo: [ :ic |
			ic innerImageColor: (e valueOfTokenNamed: #'color-text-disabled') ].
		e endElementDo: [ :ic |
			(ic respondsTo: #innerImageColor:) ifTrue: [
				ic innerImageColor: (e valueOfTokenNamed: #'color-text-disabled') ] ].
		e labelDo: [ :lab |
			lab foreground: (e valueOfTokenNamed: #'color-text-disabled') ].
		e background: BlBackground transparent.
		e border: BlBorder empty ]
]

{ #category : #'event handling' }
ToCheckboxSkin >> enabledSkinEvent: anEvent [

	super enabledSkinEvent: anEvent.
	anEvent elementDo: [ :e |
			e border: BlBorder empty.
			(e isMenuButton or: [
				 e anyInParentsSatisfy: [ :p | p isKindOf: ToNodeContainer ] ])
				ifTrue: [ e background: BlBackground transparent ].
			e icon innerImageColor: (e valueOfTokenNamed: #'checkbox-color') ]
]

{ #category : #'event handling' }
ToCheckboxSkin >> hoveredSkinEvent: anEvent [

	super hoveredSkinEvent: anEvent.
	anEvent elementDo: [ :e |
			e icon innerImageColor: (e valueOfTokenNamed: #'checkbox-color').
			e border: BlBorder empty ]
]

{ #category : #accessing }
ToCheckboxSkin >> iconGeometryIn: aCheckbox [

	^ BlRoundedRectangleGeometry cornerRadius: 4
]

{ #category : #'event handling' }
ToCheckboxSkin >> indeterminateSkinEvent: anEvent [

	super indeterminateSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e icon
			innerImage: (e valueOfTokenNamed: 'checkbox-indeterminate-image');
			innerImageColor: (e valueOfTokenNamed: #'checkbox-color');
			extent: (e valueOfTokenNamed: #'checkable-icon-size') ]
]

{ #category : #'event handling' }
ToCheckboxSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.

	anEvent elementDo: [ :e |
			e isMenuButton ifFalse: [
					e hasLabel
						ifTrue: [
						e startInterspace: (e valueOfTokenNamed: #'button-interspace') ]
						ifFalse: [ e startInterspace: 0 ].
					(e hasEndElement and: [ e hasLabel ])
						ifTrue: [
						e endInterspace: (e valueOfTokenNamed: #'button-interspace') ]
						ifFalse: [ e endInterspace: 0 ] ].
			e icon:
				(ToImage inner: (e valueOfTokenNamed: #'checkbox-unchecked-image')).
			e icon extent: (e valueOfTokenNamed: #'checkable-icon-size').
			e icon innerImageColor: (e valueOfTokenNamed: #'checkbox-color').
			e border: BlBorder empty ]
]

{ #category : #'event handling' }
ToCheckboxSkin >> leavedSkinEvent: anEvent [

	super leavedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e iconDo: [ :ic |
					ic innerImageColor: (e valueOfTokenNamed: #'checkbox-color') ].
		e labelDo: [ :lab |
			lab foreground: (e valueOfTokenNamed: #'color-text') ].
		e border: BlBorder empty ]
]

{ #category : #'event handling' }
ToCheckboxSkin >> leftSkinEvent: anEvent [

	super leftSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e iconDo: [ :ic |
					ic innerImageColor: (e valueOfTokenNamed: #'checkbox-color') ].
		e labelDo: [ :lab |
			lab foreground: (e valueOfTokenNamed: #'color-text') ].
		e border: BlBorder empty ]
]

{ #category : #'event handling' }
ToCheckboxSkin >> uncheckedSkinEvent: anEvent [

	super uncheckedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e icon
			innerImage: (e valueOfTokenNamed: #'checkbox-unchecked-image');
			innerImageColor: (e valueOfTokenNamed: #'checkbox-color') ]
]

{ #category : #'event handling' }
ToCheckboxSkin >> uninstallSkinEvent: anEvent [

	super uninstallSkinEvent: anEvent.
	anEvent elementDo: [ :e | e icon: nil ]
]
