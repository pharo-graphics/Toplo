Class {
	#name : #ToInfiniteCommandTypeOther,
	#superclass : #BlInfiniteDataSourceCommandType,
	#category : #'Toplo-Widget-List-Infinite'
}

{ #category : #dispatch }
ToInfiniteCommandTypeOther >> apply: aCommand in: anInfiniteElement [
	| command tmpStart tmpCount tmpEnd type position manager |
	command := aCommand.
	tmpStart := command positionStart.
	tmpCount := 0.
	tmpEnd := command positionStart + command itemCount.
	type := -1.
	manager := anInfiniteElement dataSourceManager.

	position := command positionStart.
	[ position < tmpEnd ]  whileTrue: [
		| holder |
		holder := holder := self elementHolderAt: position in: anInfiniteElement.
		
		(holder isNotNil or: [ anInfiniteElement dataSourceManager canFindInPreLayout: position  ])
			ifTrue: [ 
				type = command typeInvisible ifTrue: [ 
					self dispatchOn: anInfiniteElement start: tmpStart count: tmpCount.
					tmpCount := 0.
					tmpStart := position ].
				type := command typeNewOrLaidOut ]
			ifFalse: [ 
				type = command typeNewOrLaidOut ifTrue: [ 
					self postponeOn: anInfiniteElement start: tmpStart count: tmpCount.
					tmpCount := 0.
					tmpStart := position ].
				type := command typeInvisible ].

		tmpCount := tmpCount + 1.
		position := position + 1 ].
	
	(tmpCount ~= command itemCount) ifTrue: [ 
		manager recycleCommand: command.
		command := manager createCommand: self
			positionStart: tmpStart
			itemCount: tmpCount ].

	type = command typeInvisible
		ifTrue: [ manager dispatchAndUpdateElementHolders: command on: anInfiniteElement ]
		ifFalse: [ manager postponeAndUpdateElementHolders: command on: anInfiniteElement ]
]

{ #category : #dispatch }
ToInfiniteCommandTypeOther >> apply: aCommand onPosition: aPosition [
	^ aPosition
]

{ #category : #dispatch }
ToInfiniteCommandTypeOther >> continuous: aPosition start: start [
	^ aPosition = (start + 1)
]

{ #category : #dispatch }
ToInfiniteCommandTypeOther >> dispatch: aCommand toLayout: aLayout [
	aLayout onItemsUpdatedAt: aCommand positionStart count: aCommand itemCount
]

{ #category : #private }
ToInfiniteCommandTypeOther >> dispatchOn: anInfiniteElement start: aStartPosition count: anItemCount [
	| newCommand manager |
	manager := anInfiniteElement dataSourceManager.
	newCommand := manager createCommand: self
		positionStart: aStartPosition
		itemCount: anItemCount.
	manager dispatchAndUpdateElementHolders: newCommand on: anInfiniteElement.
]

{ #category : #testing }
ToInfiniteCommandTypeOther >> isUpdate [
	^ true
]

{ #category : #dispatch }
ToInfiniteCommandTypeOther >> offsetPositions: aCommand in: anInfiniteElement [

	anInfiniteElement dataSourceManager
		markElementHoldersUpdated: aCommand positionStart
		itemCount: aCommand itemCount
		in: anInfiniteElement

]

{ #category : #dispatch }
ToInfiniteCommandTypeOther >> positionMultiplier [
	^ 1
]

{ #category : #private }
ToInfiniteCommandTypeOther >> postponeOn: aContext start: aStartPosition count: anItemCount [ 
	|newCommand|
	newCommand := aContext dataSourceManager createCommand: self
		positionStart: aStartPosition
		itemCount: anItemCount.
	aContext dataSourceManager postponeAndUpdateElementHolders: newCommand on: aContext
]

{ #category : #dispatch }
ToInfiniteCommandTypeOther >> updateElementHoldersIn: anInfiniteElement command: aCommand [

	anInfiniteElement dataSourceManager
		markElementHoldersUpdated: aCommand positionStart
		itemCount: aCommand itemCount
		in: anInfiniteElement
]

{ #category : #dispatch }
ToInfiniteCommandTypeOther >> updateElementHoldersIn: anInfiniteElement offset: offsetStart command: aCommand [

	anInfiniteElement dataSourceManager
		markElementHoldersUpdated: offsetStart
		itemCount: aCommand itemCount
		in: anInfiniteElement
]

{ #category : #dispatch }
ToInfiniteCommandTypeOther >> updatePosition: aPosition with: aCommand from: myCommand [
	^ aPosition
]
