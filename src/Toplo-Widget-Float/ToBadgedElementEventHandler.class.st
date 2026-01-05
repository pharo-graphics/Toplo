Class {
	#name : #ToBadgedElementEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'badge'
	],
	#category : #'Toplo-Widget-Float'
}

{ #category : #accessing }
ToBadgedElementEventHandler >> badge: aBadge [

	badge := aBadge
]

{ #category : #'event handling' }
ToBadgedElementEventHandler >> badgeDetachedEvent: anEvent [

	anEvent badge = badge ifFalse: [ ^ self ].
	badge isAttachedToSceneGraph ifTrue: [ badge removeFromParent ].
	anEvent currentTarget removeEventHandler: self.
	badge referenceElement: nil.
	badge := nil
]

{ #category : #'event handling' }
ToBadgedElementEventHandler >> elementAddedToSceneGraphEvent: anEvent [

	badge isAttachedToSceneGraph ifFalse: [
		anEvent currentTarget space root addChild: badge ]
]

{ #category : #'event handling' }
ToBadgedElementEventHandler >> elementExtentChangedEvent: anEvent [

	badge requestLayout
]

{ #category : #'event handling' }
ToBadgedElementEventHandler >> elementPositionChangedEvent: anEvent [

	badge requestLayout
]

{ #category : #'event handling' }
ToBadgedElementEventHandler >> elementRemovedFromSceneGraphEvent: anEvent [

	badge isAttachedToSceneGraph ifFalse: [ ^ self ].
	badge removeFromParent
]

{ #category : #'api - accessing' }
ToBadgedElementEventHandler >> eventsToHandle [

	^ {
		  BlElementPositionChangedEvent.
		  BlElementExtentChangedEvent.
		  BlElementAddedToSceneGraphEvent.
		  BlElementRemovedFromSceneGraphEvent.
		  ToBadgeDetachedEvent }
]

{ #category : #'api - hooks' }
ToBadgedElementEventHandler >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	badge referenceElement: anElement.
	anElement isAttachedToSceneGraph ifTrue: [
		anElement space root addChild: badge ]
]
