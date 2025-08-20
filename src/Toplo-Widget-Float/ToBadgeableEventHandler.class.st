Class {
	#name : #ToBadgeableEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'badge'
	],
	#category : #'Toplo-Widget-Float'
}

{ #category : #'event handling' }
ToBadgeableEventHandler >> addedToSpaceEvent: anEvent [

	badge isAttachedToSceneGraph ifFalse: [
		anEvent currentTarget space root addChild: badge ]
]

{ #category : #accessing }
ToBadgeableEventHandler >> badge: aBadge [

	badge := aBadge
]

{ #category : #'event handling' }
ToBadgeableEventHandler >> badgeDetachedEvent: anEvent [

	anEvent badge = badge ifFalse: [ ^ self ].
	badge isAttachedToSceneGraph ifTrue: [ badge removeFromParent ].
	anEvent currentTarget removeEventHandler: self.
	badge referenceElement: nil.
	badge := nil
]

{ #category : #'api - accessing' }
ToBadgeableEventHandler >> eventsToHandle [

	^ {
		  ToAddedToSpaceEvent.
		  ToRemovedFromSpaceEvent.
		  ToBadgeDetachedEvent }
]

{ #category : #'api - hooks' }
ToBadgeableEventHandler >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	badge referenceElement: anElement.
	anElement isAttachedToSceneGraph ifTrue: [
		anElement space root addChild: badge ]
]

{ #category : #'event handling' }
ToBadgeableEventHandler >> removedFromSpaceEvent: anEvent [

	badge isAttachedToSceneGraph ifFalse: [ ^ self ].
	badge removeFromParent
]
