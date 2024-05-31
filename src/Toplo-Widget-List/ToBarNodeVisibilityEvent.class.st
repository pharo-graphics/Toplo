Class {
	#name : #ToBarNodeVisibilityEvent,
	#superclass : #BlEvent,
	#instVars : [
		'invisibleNodes'
	],
	#category : #'Toplo-Widget-List-InnerBar'
}

{ #category : #accessing }
ToBarNodeVisibilityEvent >> invisibleNodes [

	^ invisibleNodes
]

{ #category : #accessing }
ToBarNodeVisibilityEvent >> invisibleNodes: anArray [

	invisibleNodes := anArray
]

{ #category : #sending }
ToBarNodeVisibilityEvent >> sendTo: anObject [

	anObject barNodeVisibilityEvent: self
]
