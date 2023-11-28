Class {
	#name : 'ToCheckboxSkin',
	#superclass : 'ToButtonSkin',
	#category : 'Toplo-Widget-Button-Checkable',
	#package : 'Toplo-Widget-Button',
	#tag : 'Checkable'
}

{ #category : 'event handling' }
ToCheckboxSkin >> checkedLookEvent: anEvent [

	super checkedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e icon innerImage border: e imageCheckedBorder.
		e indeterminateChild background: Color transparent ]
]

{ #category : 'accessing' }
ToCheckboxSkin >> defaultBlankCheckboxImageIn: aCheckbox [

	^ (aCheckbox tokenValueNamed: #'checkbox-image-builder') value
]

{ #category : 'accessing' }
ToCheckboxSkin >> defaultBorderIn: aCheckbox [

	^ aCheckbox tokenValueNamed: #'color-border-checkable'
]

{ #category : 'accessing' }
ToCheckboxSkin >> defaultImageBorderIn: aCheckbox [

	^ self defaultImageColorIn: aCheckbox
]

{ #category : 'accessing' }
ToCheckboxSkin >> defaultImageColorIn: aCheckbox [

	^ aCheckbox tokenValueNamed: #'color-primary'
]

{ #category : 'accessing' }
ToCheckboxSkin >> disabledBackgroundIn: aCheckbox [

	^ Color transparent
]

{ #category : 'accessing' }
ToCheckboxSkin >> disabledBorderIn: aCheckbox [

	^ Color transparent
]

{ #category : 'event handling' }
ToCheckboxSkin >> disabledLookEvent: anEvent [

	super disabledLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e background: e disabledBackground.
		e border: e disabledBorder.
		e icon innerImage border: Color lightGray"(self defaultBorderIn: e)".
		e icon border: Color transparent.
		e indeterminateChild background: Color transparent ]
]

{ #category : 'event handling' }
ToCheckboxSkin >> enabledLookEvent: anEvent [

	super enabledLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e border: (BlBorder empty).
		e background: e defaultBackground.
		e icon border: e iconDefaultBorder ]
]

{ #category : 'accessing' }
ToCheckboxSkin >> hoveredBorderIn: aCheckbox [

	^ Color transparent
]

{ #category : 'event handling' }
ToCheckboxSkin >> hoveredLookEvent: anEvent [

	super hoveredLookEvent: anEvent.
	anEvent elementDo: [ :e | 
		e border: (BlBorder empty).		
		e mouseCursor: BlCursor hand.
		e icon border: e iconHoveredBorder ]
]

{ #category : 'accessing' }
ToCheckboxSkin >> iconDefaultBorderIn: aCheckbox [

	^ BlBorder paint: (Color lightGray alpha: 0.2) width: 1
]

{ #category : 'accessing' }
ToCheckboxSkin >> iconGeometryIn: aCheckbox [

	^ BlRoundedRectangleGeometry cornerRadius: 4
]

{ #category : 'accessing' }
ToCheckboxSkin >> iconHoveredBorderIn: aCheckbox [

	^ BlBorder paint: (self defaultImageColorIn: aCheckbox) width: 1
]

{ #category : 'accessing' }
ToCheckboxSkin >> imageCheckedBorderIn: aCheckbox [

	^ BlBorder paint: (self defaultImageBorderIn: aCheckbox) width: 6
]

{ #category : 'accessing' }
ToCheckboxSkin >> imageIndeterminateBorderIn: aCheckbox [

	^ BlBorder paint: (self defaultImageBorderIn: aCheckbox) width: 0
]

{ #category : 'accessing' }
ToCheckboxSkin >> imageUncheckedBorderIn: aCheckbox [

	^ BlBorder paint: (self defaultImageBorderIn: aCheckbox) width: 0
]

{ #category : 'event handling' }
ToCheckboxSkin >> indeterminateLookEvent: anEvent [

	super indeterminateLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e icon innerImage border: e imageIndeterminateBorder.
		e indeterminateChild background: e defaultImageColor]
]

{ #category : 'event handling' }
ToCheckboxSkin >> installIconImageIn: aCheckbox [

	aCheckbox icon innerImage border: aCheckbox imageUncheckedBorder
]

{ #category : 'event handling' }
ToCheckboxSkin >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e | 
		e interspace: 10.
		e border: (self defaultBorderIn: e).		
		e iconImage: (self defaultBlankCheckboxImageIn: e).
		e icon geometry: (self iconGeometryIn: e).
		e padding: (BlInsets
				 top: (e tokenValueNamed: #'padding-content-V-S')
				 left: (e tokenValueNamed: #'padding-content-H')
				 bottom: (e tokenValueNamed: #'padding-content-V-S')
				 right: (e tokenValueNamed: #'padding-content-H')).
		e icon border: (self defaultImageBorderIn: e) ]
	
]

{ #category : 'event handling' }
ToCheckboxSkin >> leavedLookEvent: anEvent [

	super leavedLookEvent: anEvent.
	anEvent elementDo: [ :e | 
		e border: (BlBorder empty).		
		e icon border: e iconDefaultBorder ]
]

{ #category : 'event handling' }
ToCheckboxSkin >> pressedLookEvent: anEvent [

	super pressedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e border: BlBorder empty ]
]

{ #category : 'event handling' }
ToCheckboxSkin >> uncheckedLookEvent: anEvent [

	super uncheckedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e icon innerImage border: e imageUncheckedBorder.
		e indeterminateChild background: Color transparent ]
]
