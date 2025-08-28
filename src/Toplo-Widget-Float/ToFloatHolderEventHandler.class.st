Class {
	#name : #ToFloatHolderEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'badge'
	],
	#category : #'Toplo-Widget-Float'
}

{ #category : #'event handling' }
ToFloatHolderEventHandler >> addedToSpaceEvent: anEvent [

	badge isAttachedToSceneGraph ifFalse: [
		anEvent currentTarget space root addChild: badge ]
]

{ #category : #accessing }
ToFloatHolderEventHandler >> badge: aBadge [

	badge := aBadge
]

{ #category : #'event handling' }
ToFloatHolderEventHandler >> badgeDetachedEvent: anEvent [

	anEvent badge = badge ifFalse: [ ^ self ].
	badge isAttachedToSceneGraph ifTrue: [ badge removeFromParent ].
	anEvent currentTarget removeEventHandler: self.
	badge referenceElement: nil.
	badge := nil
]

{ #category : #'api - accessing' }
ToFloatHolderEventHandler >> eventsToHandle [

	^ {
		  ToAddedToSpaceEvent.
		  ToRemovedFromSpaceEvent.
		  ToBadgeDetachedEvent }
]

{ #category : #'api - hooks' }
ToFloatHolderEventHandler >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	badge referenceElement: anElement.
	anElement isAttachedToSceneGraph ifTrue: [
		anElement space root addChild: badge ]
]

{ #category : #'event handling' }
ToFloatHolderEventHandler >> removedFromSpaceEvent: anEvent [

	badge isAttachedToSceneGraph ifFalse: [ ^ self ].
	badge removeFromParent
]
