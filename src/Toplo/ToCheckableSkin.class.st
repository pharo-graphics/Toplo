Class {
	#name : #ToCheckableSkin,
	#superclass : #ToWidgetSkin,
	#category : #'Toplo-Widget-Button-Skins'
}

{ #category : #accessing }
ToCheckableSkin >> checkedImageIn: anElement [

	^ self subclassResponsibility 
]

{ #category : #'event handling' }
ToCheckableSkin >> elementLookEvent: anEvent [

	super elementLookEvent: anEvent.
	" redirect the event to the icon skin that should have a border look 
	which react itself on event such as hovered/pressed/initial "
	anEvent elementDo: [ :e |
		e icon ifNotNil: [	 
			e icon dispatchEvent: anEvent clone ] ]
]

{ #category : #accessing }
ToCheckableSkin >> iconSkin [

	self subclassResponsibility 
]

{ #category : #accessing }
ToCheckableSkin >> indeterminateImageIn: anElement [

	^ self subclassResponsibility 
]

{ #category : #accessing }
ToCheckableSkin >> uncheckedImageIn: anElement [

	^ self subclassResponsibility 
]

{ #category : #'api - install/uninstall  hook' }
ToCheckableSkin >> whenAddedToSpace: anEvent in: anElement [

	super whenAddedToSpace: anEvent in: anElement.
	anElement spacingWidth:
		anElement toTheme paddingContentHorizontal / 2.
	anElement icon: (ToImage inner: (anElement isChecked
				  ifTrue: [ self checkedImageIn: anElement ]
				  ifFalse: [ self uncheckedImageIn: anElement ])).
	anElement icon withSkin: self iconSkin.
	self addLook: (ToCheckLook new
			 checkedImage: (self checkedImageIn: anElement);
			 uncheckedImage: (self uncheckedImageIn: anElement);
			 indeterminateImage: (self indeterminateImageIn: anElement);
			 yourself)
]
