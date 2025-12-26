Trait {
	#name : #TToFiniteListElement,
	#category : #'Toplo-Widget-List-Core'
}

{ #category : #'t - finite list element - configuration' }
TToFiniteListElement >> autoDistribute [ 

	^ self innerConfiguration autoDistribute
]

{ #category : #'t - finite list element - configuration' }
TToFiniteListElement >> autoDistribute: aBoolean [

	self innerConfiguration autoDistribute: aBoolean
]

{ #category : #'t - finite list element - configuration' }
TToFiniteListElement >> isFlowable [

	^ self innerConfiguration isFlowable
]

{ #category : #'t - finite list element - configuration' }
TToFiniteListElement >> isFlowable: aBoolean [

	self innerConfiguration isFlowable: aBoolean
]

{ #category : #'t - finite list element - configuration' }
TToFiniteListElement >> isScrollable [

	^ self innerConfiguration isScrollable
]

{ #category : #'t - finite list element - configuration' }
TToFiniteListElement >> isScrollable: aBoolean [

	self innerConfiguration isScrollable: aBoolean
]

{ #category : #'t - finite list element - configuration' }
TToFiniteListElement >> uniformNodeHeight [

	^ self innerConfiguration uniformNodeHeight
]

{ #category : #'t - finite list element - configuration' }
TToFiniteListElement >> uniformNodeHeight: aBoolean [

	self innerConfiguration uniformNodeHeight: aBoolean
]

{ #category : #'t - finite list element - configuration' }
TToFiniteListElement >> uniformNodeWidth [

	^ self innerConfiguration uniformNodeWidth
]

{ #category : #'t - finite list element - configuration' }
TToFiniteListElement >> uniformNodeWidth: aBoolean [

	self innerConfiguration uniformNodeWidth: aBoolean
]
