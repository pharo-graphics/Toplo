Class {
	#name : #ToBarVisibleNodeListChangedEvent,
	#superclass : #BlEvent,
	#instVars : [
		'visibleNodes',
		'invisibleNodes'
	],
	#category : #'Toplo-Widget-List-InnerBar'
}

{ #category : #accessing }
ToBarVisibleNodeListChangedEvent >> invisibleNodes [

	^ invisibleNodes
]

{ #category : #accessing }
ToBarVisibleNodeListChangedEvent >> invisibleNodes: anArray [

	invisibleNodes := anArray
]

{ #category : #sending }
ToBarVisibleNodeListChangedEvent >> sendTo: anObject [

	anObject barVisibleNodeListChangedEvent: self
]

{ #category : #accessing }
ToBarVisibleNodeListChangedEvent >> visibleNodes [

	^ visibleNodes
]

{ #category : #accessing }
ToBarVisibleNodeListChangedEvent >> visibleNodes: anArray [

	visibleNodes := anArray
]
