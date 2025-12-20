Trait {
	#name : #TToConfigurableFiniteListElementDeprecated,
	#category : #'Toplo-Widget-List-Core-FiniteListElement'
}

{ #category : #accessing }
TToConfigurableFiniteListElementDeprecated >> autoDistribute [

	self
		  deprecated: 'Use toConfiguration'
		  transformWith:
		  '`@rcvr autoDistribute' -> '`@rcvr toConfiguration autoDistribute'.
	^ self toConfiguration autoDistribute
]

{ #category : #accessing }
TToConfigurableFiniteListElementDeprecated >> autoDistribute: anObject [

	self
		  deprecated: 'Use toConfiguration'
		  transformWith:
		  '`@rcvr autoDistribute: `@arg' -> '`@rcvr toConfiguration autoDistribute: `@arg'.
	self toConfiguration autoDistribute: anObject
]

{ #category : #accessing }
TToConfigurableFiniteListElementDeprecated >> isFlowable [

	self
		  deprecated: 'Use toConfiguration'
		  transformWith:
		  '`@rcvr isFlowable' -> '`@rcvr toConfiguration isFlowable'.
	^ self toConfiguration isFlowable
]

{ #category : #accessing }
TToConfigurableFiniteListElementDeprecated >> isFlowable: anObject [

	self
		  deprecated: 'Use toConfiguration'
		  transformWith:
		  '`@rcvr isFlowable: `@arg' -> '`@rcvr toConfiguration isFlowable: `@arg'.
	self toConfiguration isFlowable: anObject
]

{ #category : #accessing }
TToConfigurableFiniteListElementDeprecated >> isScrollable [

	self
		  deprecated: 'Use toConfiguration'
		  transformWith:
		  '`@rcvr isScrollable' -> '`@rcvr toConfiguration isScrollable'.
	^ self toConfiguration isScrollable
]

{ #category : #accessing }
TToConfigurableFiniteListElementDeprecated >> isScrollable: anObject [

	self
		  deprecated: 'Use toConfiguration'
		  transformWith:
		  '`@rcvr isScrollable: `@arg' -> '`@rcvr toConfiguration isScrollable: `@arg'.
	self toConfiguration isScrollable: anObject
]

{ #category : #accessing }
TToConfigurableFiniteListElementDeprecated >> uniformNodeHeight [

	self
		  deprecated: 'Use toConfiguration'
		  transformWith:
		  '`@rcvr uniformNodeHeight' -> '`@rcvr toConfiguration uniformNodeHeight'.
	^ self toConfiguration uniformNodeHeight
]

{ #category : #accessing }
TToConfigurableFiniteListElementDeprecated >> uniformNodeHeight: anObject [

	self
		  deprecated: 'Use toConfiguration'
		  transformWith:
		  '`@rcvr uniformNodeHeight: `@arg' -> '`@rcvr toConfiguration uniformNodeHeight: `@arg'.
	self toConfiguration uniformNodeHeight: anObject
]

{ #category : #accessing }
TToConfigurableFiniteListElementDeprecated >> uniformNodeWidth [

	self
		  deprecated: 'Use toConfiguration'
		  transformWith:
		  '`@rcvr uniformNodeWidth' -> '`@rcvr toConfiguration uniformNodeWidth'.
	^ self toConfiguration uniformNodeWidth
]

{ #category : #accessing }
TToConfigurableFiniteListElementDeprecated >> uniformNodeWidth: anObject [

	self
		  deprecated: 'Use toConfiguration'
		  transformWith:
		  '`@rcvr uniformNodeWidth: `@arg' -> '`@rcvr toConfiguration uniformNodeWidth: `@arg'.
	self toConfiguration uniformNodeWidth: anObject
]
