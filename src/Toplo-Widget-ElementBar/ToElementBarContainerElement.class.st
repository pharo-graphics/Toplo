Class {
	#name : #ToElementBarContainerElement,
	#superclass : #ToElement,
	#traits : 'TToOrientable',
	#classTraits : 'TToOrientable classTrait',
	#category : #'Toplo-Widget-ElementBar'
}

{ #category : #adding }
ToElementBarContainerElement >> addFakeNode [

	innerNodeContainer addChild: fakeNode
]

{ #category : #initialization }
ToElementBarContainerElement >> defaultNodeClass [

	^ ToElementBarNode
]

{ #category : #'api - hooks' }
ToElementBarContainerElement >> onInstalledIn: anElementBar [

	elementBar := anElementBar.
	self isHorizontal
		ifTrue: [
			self
				vFitContent;
				hMatchParent;
				constraintsDo: [ :c | c linear vertical alignCenter ] ]
		ifFalse: [
			self
				hFitContent;
				vMatchParent;
				constraintsDo: [ :c | c linear horizontal alignCenter ] ]
]

{ #category : #'api - hooks' }
ToElementBarContainerElement >> onUninstalledIn: anElementBar [

	elementBar := nil
]

{ #category : #accessing }
ToElementBarContainerElement >> refresh [

	self subclassResponsibility 
]

{ #category : #initialization }
ToElementBarContainerElement >> uninstallFakeNode [
	" the fake node is added when no data is selected to ensure a 
	suitable minimum height according to the node class, the node builder 
	and the data kind."

	fakeNode ifNotNil: [ :fn |
		fn onUninstalledIn: self.
		fn removeFromParent ].
	fakeNode := nil
]
