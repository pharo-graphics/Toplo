Class {
	#name : #ToTreeDataSource,
	#superclass : #ToInfiniteCollectionDataSource,
	#category : #'Toplo-Widget-Tree-Core'
}

{ #category : #accessing }
ToTreeDataSource >> itemsAtPath: aPath [

	| item items |
	(aPath isNil or: [ aPath isEmpty ]) ifTrue: [ ^ #() ].

	items := OrderedCollection new.
	item := self rootAt: aPath first.
	items add: item.
	
	aPath allButFirstDo: [ :childIndex |
		item expand.
		item := item childWrapperAt: childIndex.
		items add: item ].

	^ items
]

{ #category : #accessing }
ToTreeDataSource >> pathOfIndex: index [

	| path currentWrapper |
	path := OrderedCollection new.
	
	currentWrapper := self at: index.

	[ currentWrapper isNil ] whileFalse: [
		path addFirst: currentWrapper position.
		currentWrapper := currentWrapper parentWrapper ].
	
	path := path withIndexCollect: [ :x :i |
		i = 1
			ifTrue: [ self roots indexOf: (self at: path first) ]
			ifFalse: [ x - (path at: i - 1) ] ].
	
	^ path
]

{ #category : #accessing }
ToTreeDataSource >> rootAt: index [

	| rootCount |
	rootCount := 0.
	self do: [ :w |
		w isRoot ifTrue: [
			rootCount := rootCount + 1.
			rootCount = index ifTrue: [ ^ w ] ] ].

	^ self error
]

{ #category : #accessing }
ToTreeDataSource >> roots [

	^ self select: [ :w | w isRoot ]
]
