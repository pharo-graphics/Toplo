Extension { #name : #BlCompositeSelection }

{ #category : #'*Toplo-Widget-List' }
BlCompositeSelection >> deselectIndex: aFirstIndex to: aSecondIndex [

	| from to |
	from := aFirstIndex min: aSecondIndex.
	to := aFirstIndex max: aSecondIndex.
	(from <= to and: [ from > 0 and: [ to >= 0 ] ]) ifFalse: [ ^ self ].
	self deselect: from - 1 to: to
]

{ #category : #'*Toplo-Widget-List' }
BlCompositeSelection >> firstIndex [

	self ifEmpty: [ ^ 0 ].
	^  self from + 1
]

{ #category : #'*Toplo-Widget-List' }
BlCompositeSelection >> indicesCount [

	| count |
	count := 0.
	self do: [ :s | count := count + s interval size - 1 ].
	^ count
]

{ #category : #'*Toplo-Widget-List' }
BlCompositeSelection >> intervals [
	" return an array of intervals #( 2 3 4 6 7 8 ) -> { 2 to: 4. 6 to: 8 } "

	^ Array streamContents: [ :stream |
		  self intervalsDo: [ :interval |
			  stream nextPut: interval ] ]
]

{ #category : #'*Toplo-Widget-List' }
BlCompositeSelection >> intervalsDo: aBlock [
	" aBlock has one interval argument "

	| prev g |
	g := nil.
	prev := nil.
	self indicesDo: [ :idx |
		prev ifNil: [ g := idx to: idx ] ifNotNil: [
			prev + 1 = idx
				ifTrue: [ g := g first to: idx ]
				ifFalse: [
					aBlock value: g.
					g := idx to: idx ] ].
		prev := idx ].
	g ifNotNil: [ aBlock value: g ]
]

{ #category : #'*Toplo-Widget-List' }
BlCompositeSelection >> lastIndex [

	self ifEmpty: [ ^ 0 ].
	^ self to
]

{ #category : #'*Toplo-Widget-List' }
BlCompositeSelection >> removeIntervalFromIndex: aFromIndex toIndex: aToIndex [

	self selections delete:
		(BlMonotoneSelection from: (aFromIndex - 1 max: 0) to: aToIndex)
]

{ #category : #'*Toplo-Widget-List' }
BlCompositeSelection >> selectIndex: aFirstIndex to: aSecondIndex [

	| from to |
	from := aFirstIndex min: aSecondIndex.
	to := aFirstIndex max: aSecondIndex.
	self select: from - 1 to: to
]
