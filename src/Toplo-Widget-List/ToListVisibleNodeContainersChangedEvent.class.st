Class {
	#name : #ToListVisibleNodeContainersChangedEvent,
	#superclass : #BlEvent,
	#instVars : [
		'invisibleNodeContainers',
		'visibleNodeContainers'
	],
	#category : #'Toplo-Widget-List-InnerList'
}

{ #category : #accessing }
ToListVisibleNodeContainersChangedEvent >> invisibleNodeContainers [

	^ invisibleNodeContainers
]

{ #category : #accessing }
ToListVisibleNodeContainersChangedEvent >> invisibleNodeContainers: anArray [

	invisibleNodeContainers := anArray
]

{ #category : #sending }
ToListVisibleNodeContainersChangedEvent >> sendTo: anObject [

	anObject listVisibleNodeContainersChangedEvent: self
]

{ #category : #accessing }
ToListVisibleNodeContainersChangedEvent >> visibleNodeContainers [

	^ visibleNodeContainers
]

{ #category : #accessing }
ToListVisibleNodeContainersChangedEvent >> visibleNodeContainers: anArray [

	visibleNodeContainers := anArray
]
