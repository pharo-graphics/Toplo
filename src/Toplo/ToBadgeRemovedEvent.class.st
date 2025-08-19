Class {
	#name : #ToBadgeRemovedEvent,
	#superclass : #BlEvent,
	#instVars : [
		'badge'
	],
	#category : #'Toplo-Core'
}

{ #category : #accessing }
ToBadgeRemovedEvent >> badge [

	^ badge
]

{ #category : #accessing }
ToBadgeRemovedEvent >> badge: aBadge [

	badge := aBadge
]

{ #category : #sending }
ToBadgeRemovedEvent >> sendTo: anObject [

	anObject badgeRemovedEvent: self 
]
