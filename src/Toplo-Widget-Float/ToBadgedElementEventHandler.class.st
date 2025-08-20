Class {
	#name : #ToBadgedElementEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'badge'
	],
	#category : #'Toplo-Widget-Float'
}

{ #category : #'event handling' }
ToBadgedElementEventHandler >> addedToSpaceEvent: anEvent [

	badge isAttachedToSceneGraph ifFalse: [
		anEvent currentTarget space root addChild: badge ]
]

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

{ #category : #'api - accessing' }
ToBadgedElementEventHandler >> eventsToHandle [

	^ {
		  ToAddedToSpaceEvent.
		  ToRemovedFromSpaceEvent.
		  ToBadgeDetachedEvent }
]

{ #category : #'api - hooks' }
ToBadgedElementEventHandler >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	badge referenceElement: anElement.
	anElement isAttachedToSceneGraph ifTrue: [
		anElement space root addChild: badge ]
]

{ #category : #'event handling' }
ToBadgedElementEventHandler >> removedFromSpaceEvent: anEvent [

	badge isAttachedToSceneGraph ifFalse: [ ^ self ].
	badge removeFromParent
]
