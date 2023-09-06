Class {
	#name : #ToMonoColorFlatImageFormLook,
	#superclass : #ToElementLook,
	#instVars : [
		'initialColor',
		'hoverColor',
		'pressedColor',
		'disabledColor',
		'selectedColor'
	],
	#category : #'Toplo-Theme-Look'
}

{ #category : #'event handling' }
ToMonoColorFlatImageFormLook >> adaptForegroundIn: anElement withColor: aColor [

	anElement
		withInnerFormDo: [ :form |
			| newForm |
			newForm := form collectColors: [ :color | aColor alpha: color alpha ].
			anElement innerImage: newForm ]
		ifNone: [  ]
]

{ #category : #accessing }
ToMonoColorFlatImageFormLook >> disabledColor [

	^ disabledColor
]

{ #category : #accessing }
ToMonoColorFlatImageFormLook >> disabledColor: aValuable [

	disabledColor := aValuable
]

{ #category : #'event handling' }
ToMonoColorFlatImageFormLook >> disabledLookEvent: anEvent [

	super disabledLookEvent: anEvent.
	self disabledColor ifNil: [ ^ self ].
	anEvent elementDo: [ :e |
		self adaptForegroundIn: e withColor: (self disabledColor value: e) ]
]

{ #category : #accessing }
ToMonoColorFlatImageFormLook >> hoverColor [

	^ hoverColor
]

{ #category : #accessing }
ToMonoColorFlatImageFormLook >> hoverColor: aValuable [

	hoverColor := aValuable
]

{ #category : #'event handling' }
ToMonoColorFlatImageFormLook >> hoveredLookEvent: anEvent [

	super hoveredLookEvent: anEvent.
	self hoverColor ifNil: [ ^ self ].
	anEvent elementDo: [ :e |
		self adaptForegroundIn: e withColor: (self hoverColor value: e) ]
]

{ #category : #accessing }
ToMonoColorFlatImageFormLook >> initialColor [

	^ initialColor
]

{ #category : #accessing }
ToMonoColorFlatImageFormLook >> initialColor: aValuable [

	initialColor := aValuable
]

{ #category : #'event handling' }
ToMonoColorFlatImageFormLook >> initialLookEvent: anEvent [

	super initialLookEvent: anEvent.
	self initialColor ifNil: [ ^ self ].
	anEvent elementDo: [ :e |
		self adaptForegroundIn: e withColor: (self initialColor value: e) ]
]

{ #category : #accessing }
ToMonoColorFlatImageFormLook >> pressedColor [

	^ pressedColor
]

{ #category : #accessing }
ToMonoColorFlatImageFormLook >> pressedColor: aValuable [

	pressedColor := aValuable
]

{ #category : #'event handling' }
ToMonoColorFlatImageFormLook >> pressedLookEvent: anEvent [

	super pressedLookEvent: anEvent.
	self pressedColor ifNil: [ ^ self ].
	anEvent elementDo: [ :e |
		self adaptForegroundIn: e withColor: (self pressedColor value: e)]
]

{ #category : #accessing }
ToMonoColorFlatImageFormLook >> selectedColor [

	^ selectedColor
]

{ #category : #accessing }
ToMonoColorFlatImageFormLook >> selectedColor: aValuable [

	selectedColor := aValuable
]

{ #category : #'event handling' }
ToMonoColorFlatImageFormLook >> selectedLookEvent: anEvent [

	super selectedLookEvent: anEvent.
	self selectedColor ifNil: [ ^ self ].
	anEvent elementDo: [ :e |
		self adaptForegroundIn: e withColor: (self selectedColor value: e) ]
]
