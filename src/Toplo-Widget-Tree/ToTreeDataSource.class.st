Class {
	#name : #ToTreeDataSource,
	#superclass : #ToInfiniteCollectionDataSource,
	#category : #'Toplo-Widget-Tree-Core'
}

{ #category : #'as yet unclassified' }
ToTreeDataSource >> itemsAtPath: aPath [

	| item items |
	(aPath isNil or: [ aPath isEmpty ]) ifTrue: [ ^ #() ].

	items := OrderedCollection new.
	item := self roots at: aPath first.
	items add: item.
	
	aPath allButFirstDo: [ :index |
		item expand.
		item := item childWrapperAt: index.
		items add: item ].

	^ items
]

{ #category : #'as yet unclassified' }
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

{ #category : #enumerating }
ToTreeDataSource >> rootAt: index [

	| count |
	count := 1.
	self rootsDo: [ :w |
		count = index ifTrue: [ ^ w ].
		count := count + 1 ].

	^ self error
]

{ #category : #enumerating }
ToTreeDataSource >> roots [

	^ self select: [ :w | w isRoot ]
]

{ #category : #enumerating }
ToTreeDataSource >> rootsDo: aBlock [

	self do: [ :w | w isRoot ifTrue: [ aBlock value: w ] ]
]
