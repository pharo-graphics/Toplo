Trait {
	#name : #TToBasicFiniteListElementConfiguration,
	#instVars : [
		'#autoDistribute => ObservableSlot',
		'#isFlowable => ObservableSlot',
		'#isScrollable => ObservableSlot',
		'#uniformNodeWidth => ObservableSlot',
		'#uniformNodeHeight => ObservableSlot'
	],
	#category : #'Toplo-Widget-List-Core'
}

{ #category : #'t - basic finite list element configuration - accessing' }
TToBasicFiniteListElementConfiguration >> autoDistribute [

	^ autoDistribute 
]

{ #category : #'t - basic finite list element configuration - accessing' }
TToBasicFiniteListElementConfiguration >> autoDistribute: aBoolean [

	autoDistribute := aBoolean 
]

{ #category : #'t - basic finite list element configuration - accessing' }
TToBasicFiniteListElementConfiguration >> isFlowable [

	^ isFlowable ifNil: [ isFlowable := true ] 
]

{ #category : #'t - basic finite list element configuration - accessing' }
TToBasicFiniteListElementConfiguration >> isFlowable: aBoolean [

	isFlowable := aBoolean 
]

{ #category : #'t - basic finite list element configuration - accessing' }
TToBasicFiniteListElementConfiguration >> isScrollable [

	^ isScrollable ifNil: [ isScrollable := false ] 
]

{ #category : #'t - basic finite list element configuration - accessing' }
TToBasicFiniteListElementConfiguration >> isScrollable: aBoolean [

	isScrollable := aBoolean 
]

{ #category : #'t - basic finite list element configuration - accessing' }
TToBasicFiniteListElementConfiguration >> uniformNodeHeight [

	^ uniformNodeHeight ifNil: [ uniformNodeHeight := false ] 
]

{ #category : #'t - basic finite list element configuration - accessing' }
TToBasicFiniteListElementConfiguration >> uniformNodeHeight: aBoolean [

	uniformNodeHeight := aBoolean
]

{ #category : #'t - basic finite list element configuration - accessing' }
TToBasicFiniteListElementConfiguration >> uniformNodeWidth [

	^ uniformNodeWidth ifNil: [ uniformNodeWidth := false ] 
]

{ #category : #'t - basic finite list element configuration - accessing' }
TToBasicFiniteListElementConfiguration >> uniformNodeWidth: aBoolean [

	uniformNodeWidth := aBoolean
]
