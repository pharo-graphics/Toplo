Class {
	#name : #ToFiniteListVisibleNodeContainerListChangedEvent,
	#superclass : #BlEvent,
	#instVars : [
		'invisibleNodeContainers',
		'visibleNodeContainers'
	],
	#category : #'Toplo-Widget-List-InnerFiniteList'
}

{ #category : #accessing }
ToFiniteListVisibleNodeContainerListChangedEvent >> invisibleNodeContainers [

	^ invisibleNodeContainers
]

{ #category : #accessing }
ToFiniteListVisibleNodeContainerListChangedEvent >> invisibleNodeContainers: anArray [

	invisibleNodeContainers := anArray
]

{ #category : #sending }
ToFiniteListVisibleNodeContainerListChangedEvent >> sendTo: anObject [

	anObject barVisibleNodeContainerListChangedEvent: self
]

{ #category : #accessing }
ToFiniteListVisibleNodeContainerListChangedEvent >> visibleNodeContainers [

	^ visibleNodeContainers
]

{ #category : #accessing }
ToFiniteListVisibleNodeContainerListChangedEvent >> visibleNodeContainers: anArray [

	visibleNodeContainers := anArray
]
