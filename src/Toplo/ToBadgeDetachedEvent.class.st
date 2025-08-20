Class {
	#name : #ToBadgeDetachedEvent,
	#superclass : #BlEvent,
	#instVars : [
		'badge'
	],
	#category : #'Toplo-Core'
}

{ #category : #accessing }
ToBadgeDetachedEvent >> badge [

	^ badge
]

{ #category : #accessing }
ToBadgeDetachedEvent >> badge: aBadge [

	badge := aBadge
]

{ #category : #sending }
ToBadgeDetachedEvent >> sendTo: anObject [

	anObject badgeDetachedEvent: self 
]
