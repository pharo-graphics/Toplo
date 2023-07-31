Class {
	#name : #ToCheckableSkin,
	#superclass : #ToWidgetSkin,
	#category : #'Toplo-Widget-Button-Skins'
}

{ #category : #'api - install/uninstall  hook' }
ToCheckableSkin >> buttonIconChanged: anEvent [

	anEvent currentTarget icon ifNil: [ ^ self ].
	" have to change the state of the new icon so that its skin is initialized with the right state.
	As an example in case of click, a CheckBoxButton turns into HoverState and change its icon which 
	itself must be initialized into an HoverState (the same as its CheckBoxButton) "
	anEvent currentTarget icon currentSkinState: anEvent currentTarget currentSkinState.
	anEvent currentTarget icon withSkin: self iconSkin.
	
]

{ #category : #'api - install/uninstall  hook' }
ToCheckableSkin >> buttonLabelChanged: anEvent [
]

{ #category : #accessing }
ToCheckableSkin >> checkedImageIn: anElement [

	^ self subclassResponsibility 
]

{ #category : #'api - accessing' }
ToCheckableSkin >> eventsToHandle [ 

	^ super eventsToHandle, { ToButtonIconChangedEvent. ToButtonLabelChangedEvent }
]

{ #category : #accessing }
ToCheckableSkin >> iconSkin [

	self subclassResponsibility 
]

{ #category : #accessing }
ToCheckableSkin >> indeterminateImageIn: anElement [

	^ self subclassResponsibility 
]

{ #category : #'api - install/uninstall  hook' }
ToCheckableSkin >> onSkinInstalledIn: anElement [

	super onSkinInstalledIn: anElement.
	anElement spacingWidth: anElement toTheme paddingContentHorizontal / 2.
	anElement icon: (ToImage inner: (anElement isChecked
				  ifTrue: [ self checkedImageIn: anElement ]
				  ifFalse: [ self uncheckedImageIn: anElement ])).
	self addLook: (ToCheckLook new
			 checkedImage: (self checkedImageIn: anElement);
			 uncheckedImage: (self uncheckedImageIn: anElement);
			 indeterminateImage: (self indeterminateImageIn: anElement);
			 yourself)
]

{ #category : #accessing }
ToCheckableSkin >> uncheckedImageIn: anElement [

	^ self subclassResponsibility 
]
