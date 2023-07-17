Class {
	#name : #ToCheckboxSkin,
	#superclass : #ToWidgetSkin,
	#category : #'Toplo-Widget-Button-Skins'
}

{ #category : #accessing }
ToCheckboxSkin >> checkedImageIn: anElement [

	^ ToImage inner: (BlElement new
			   size: (anElement toTheme controlHeight / 2) asPoint;
			   border: (BlBorder paint: anElement toTheme colorPrimary width: 5);
			   margin: (BlInsets all: 0);
			   background: anElement toTheme colorBgContainer;
			   yourself)
]

{ #category : #'event handling' }
ToCheckboxSkin >> elementLookEvent: anEvent [

	super elementLookEvent: anEvent.
	" redirect the event to the icon skin that should have a border look 
	which react itself on event such as hovered/pressed/initial "
	anEvent elementDo: [ :e |
		e icon ifNotNil: [	 
			anEvent target: e icon.
			e icon privateSkin elementLookEvent: anEvent ] ]
]

{ #category : #accessing }
ToCheckboxSkin >> uncheckedImageIn: anElement [

	^ ToImage inner: (BlElement new
			   size: (anElement toTheme controlHeight / 2) asPoint;
			   margin: (BlInsets all: 0);
			   background: (anElement toTheme colorBgContainer alpha: 0);
			   yourself)
]

{ #category : #'api - install/uninstall  hook' }
ToCheckboxSkin >> whenAddedToSpace: anEvent in: anElement [

	super whenAddedToSpace: anEvent in: anElement.
	anElement spacingWidth: anElement toTheme paddingContentHorizontal / 2.
	anElement icon: (ToImage inner: (anElement checked ifTrue: [self checkedImageIn: anElement] ifFalse: [self uncheckedImageIn: anElement] )).
	anElement icon withSkin: ToCheckboxImageSkin new.
	self addLook: (ToCheckLook new checkedImage: (self checkedImageIn: anElement); uncheckedImage: (self uncheckedImageIn: anElement); yourself).

]
