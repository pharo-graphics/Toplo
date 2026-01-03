Trait {
	#name : #TToFiniteListElement,
	#category : #'Toplo-Widget-List-Core'
}

{ #category : #'t - finite list element - configuration' }
TToFiniteListElement >> autoDistribute [

	self
		deprecated: 'Use #innerConfiguration'
		transformWith:
		'`@rcvr autoDistribute'
		-> '`@rcvr innerConfiguration autoDistribute'.
	^ self innerConfiguration autoDistribute
]

{ #category : #'t - finite list element - configuration' }
TToFiniteListElement >> autoDistribute: aBoolean [

	self
		deprecated: 'Use #innerConfiguration'
		transformWith:
		'`@rcvr autoDistribute: `@arg'
		-> '`@rcvr innerConfiguration autoDistribute: `@arg'.
	self innerConfiguration autoDistribute: aBoolean
]

{ #category : #'t - finite list element - configuration' }
TToFiniteListElement >> isFlowable [

	self
		deprecated: 'Use #innerConfiguration'
		transformWith:
		'`@rcvr isFlowable'
		-> '`@rcvr innerConfiguration isFlowable'.
	^ self innerConfiguration isFlowable
]

{ #category : #'t - finite list element - configuration' }
TToFiniteListElement >> isFlowable: aBoolean [

	self
		deprecated: 'Use #innerConfiguration'
		transformWith:
		'`@rcvr isFlowable: `@arg'
		-> '`@rcvr innerConfiguration isFlowable: `@arg'.
	self innerConfiguration isFlowable: aBoolean
]

{ #category : #'t - finite list element - configuration' }
TToFiniteListElement >> isScrollable [

	self
		deprecated: 'Use #innerConfiguration'
		transformWith:
		'`@rcvr isScrollable'
		-> '`@rcvr innerConfiguration isScrollable'.
	^ self innerConfiguration isScrollable
]

{ #category : #'t - finite list element - configuration' }
TToFiniteListElement >> isScrollable: aBoolean [

	self
		deprecated: 'Use #innerConfiguration'
		transformWith:
		'`@rcvr isScrollable: `@arg'
		-> '`@rcvr innerConfiguration isScrollable: `@arg'.
	self innerConfiguration isScrollable: aBoolean
]

{ #category : #'t - finite list element - configuration' }
TToFiniteListElement >> uniformNodeHeight [

	self
		deprecated: 'Use #innerConfiguration'
		transformWith:
		'`@rcvr uniformNodeHeight'
		-> '`@rcvr innerConfiguration uniformNodeHeight'.
	^ self innerConfiguration uniformNodeHeight
]

{ #category : #'t - finite list element - configuration' }
TToFiniteListElement >> uniformNodeHeight: aBoolean [

	self
		deprecated: 'Use #innerConfiguration'
		transformWith:
		'`@rcvr uniformNodeHeight: `@arg'
		-> '`@rcvr innerConfiguration uniformNodeHeight: `@arg'.
	self innerConfiguration uniformNodeHeight: aBoolean
]

{ #category : #'t - finite list element - configuration' }
TToFiniteListElement >> uniformNodeWidth [

	self
		deprecated: 'Use #innerConfiguration'
		transformWith:
		'`@rcvr uniformNodeWidth'
		-> '`@rcvr innerConfiguration uniformNodeWidth'.
	^ self innerConfiguration uniformNodeWidth
]

{ #category : #'t - finite list element - configuration' }
TToFiniteListElement >> uniformNodeWidth: aBoolean [

	self
		deprecated: 'Use #innerConfiguration'
		transformWith:
		'`@rcvr uniformNodeWidth: `@arg'
		-> '`@rcvr innerConfiguration uniformNodeWidth: `@arg'.
	self innerConfiguration uniformNodeWidth: aBoolean
]
