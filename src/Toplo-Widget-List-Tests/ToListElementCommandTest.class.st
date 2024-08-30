Class {
	#name : #ToListElementCommandTest,
	#superclass : #TestCase,
	#category : #'Toplo-Widget-List-Tests-Selection-Command'
}

{ #category : #tests }
ToListElementCommandTest >> testIntervalsIn [

	| intervals cmd |
	cmd := ToIndexesSelectionCommand new.
	intervals := cmd intervalsIn: #().
	self assert: intervals isEmpty.
	intervals := cmd intervalsIn: {2}.
	self assert: intervals size equals: 1.
	intervals := cmd intervalsIn: {2. 6}.
	self assert: intervals size equals: 2.
	intervals := cmd intervalsIn: {2. 6. 9}.
	self assert: intervals size equals: 3.
	
]

{ #category : #tests }
ToListElementCommandTest >> testIntervalsIn2 [

	| intervals cmd |
	cmd := ToIndexesSelectionCommand new.
	intervals := cmd intervalsIn: {2. 3. 6}.
	self assert: intervals size equals: 2.
	self assert: intervals first equals: (2 to: 3)	.
	self assert: intervals second equals: (6 to: 6).
	
	intervals := cmd intervalsIn: {2. 3. 5. 6. 7}.
	self assert: intervals size equals: 2.
	self assert: intervals first equals: (2 to: 3)	.
	self assert: intervals second equals: (5 to: 7).

	intervals := cmd intervalsIn: {2. 3. 5. 6. 7. 10}.
	self assert: intervals size equals: 3.
	self assert: intervals first equals: (2 to: 3)	.
	self assert: intervals second equals: (5 to: 7).
	self assert: intervals third equals: (10 to: 10).
	
	intervals := cmd intervalsIn: {2. 5. 6. 7. 10}.
	self assert: intervals size equals: 3.
	self assert: intervals first equals: (2 to: 2)	.
	self assert: intervals second equals: (5 to: 7).
	self assert: intervals third equals: (10 to: 10)
]

{ #category : #tests }
ToListElementCommandTest >> testSelectionModel [

	| cmd sm |
	cmd := ToIndexesSelectionCommand new.
	cmd selectionModel: (sm := ToSelectionModel new).
	self assert: cmd selectionModel identicalTo: sm
]
