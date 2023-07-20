Class {
	#name : #ToButtonSkin,
	#superclass : #ToWidgetSkin,
	#instVars : [
		'type'
	],
	#category : #'Toplo-Widget-Button-Skins'
}

{ #category : #'api - install/uninstall  hook' }
ToButtonSkin >> buttonIconChanged: anEvent [

	anEvent currentTarget icon ifNil: [ ^ self ].
	anEvent currentTarget icon withSkin: (ToButtonImageSkin new buttonType: self type)	
]

{ #category : #'api - install/uninstall  hook' }
ToButtonSkin >> buttonLabelChanged: anEvent [

	anEvent currentTarget label ifNil: [ ^ self ].
	anEvent currentTarget label withSkin: (ToButtonLabelSkin new buttonType: self type).

]

{ #category : #accessing }
ToButtonSkin >> danger [

	^ self type danger
]

{ #category : #accessing }
ToButtonSkin >> danger: aBoolean [

	self type danger: aBoolean
]

{ #category : #accessing }
ToButtonSkin >> dashed [

	^ self type dashed
]

{ #category : #accessing }
ToButtonSkin >> dashed: aBoolean [

	self type dashed: aBoolean
]

{ #category : #'api - accessing' }
ToButtonSkin >> eventsToHandle [ 

	^ super eventsToHandle, { ToButtonIconChanged. ToButtonLabelChanged }
]

{ #category : #accessing }
ToButtonSkin >> type [

	"#default, #primary, #link or #text"

	^ type ifNil: [ type := ToButtonDefaultType new ]
]

{ #category : #accessing }
ToButtonSkin >> type: aSkinType [

	"#default, #primary, #link or #text"
	type := aSkinType
]

{ #category : #'api - install/uninstall  hook' }
ToButtonSkin >> whenAddedToSpace: anEvent in: anElement [

	" must send to super ** after ** the look is initialize from type "
	self type whenAddedToSpace: anEvent in: anElement fromSkin: self.
	super whenAddedToSpace: anEvent in: anElement.

]

{ #category : #'api - install/uninstall  hook' }
ToButtonSkin >> whenRemovedFromSpace: anEvent in: anElement [

	self type whenRemovedFromSpace: anEvent in: anElement fromSkin: self.
	super whenRemovedFromSpace: anEvent in: anElement.

]
