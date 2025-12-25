Trait {
	#name : #TToBasicListElementConfiguration,
	#instVars : [
		'#useCheckbox => ObservableSlot',
		'#autoDistribute => ObservableSlot',
		'#isFlowable => ObservableSlot',
		'#isScrollable => ObservableSlot',
		'#uniformNodeWidth => ObservableSlot',
		'#uniformNodeHeight => ObservableSlot'
	],
	#category : #'Toplo-Widget-List-Core'
}

{ #category : #'t - basic finite list element configuration - accessing' }
TToBasicListElementConfiguration >> autoDistribute [

	^ autoDistribute 
]

{ #category : #'t - basic finite list element configuration - accessing' }
TToBasicListElementConfiguration >> autoDistribute: aBoolean [

	autoDistribute := aBoolean 
]

{ #category : #'t - basic finite list element configuration - accessing' }
TToBasicListElementConfiguration >> isFlowable [

	^ isFlowable ifNil: [ isFlowable := true ] 
]

{ #category : #'t - basic finite list element configuration - accessing' }
TToBasicListElementConfiguration >> isFlowable: aBoolean [

	isFlowable := aBoolean 
]

{ #category : #'t - basic finite list element configuration - accessing' }
TToBasicListElementConfiguration >> isScrollable [

	^ isScrollable ifNil: [ isScrollable := false ] 
]

{ #category : #'t - basic finite list element configuration - accessing' }
TToBasicListElementConfiguration >> isScrollable: aBoolean [

	isScrollable := aBoolean 
]

{ #category : #'t - basic finite list element configuration - accessing' }
TToBasicListElementConfiguration >> uniformNodeHeight [

	^ uniformNodeHeight ifNil: [ uniformNodeHeight := false ] 
]

{ #category : #'t - basic finite list element configuration - accessing' }
TToBasicListElementConfiguration >> uniformNodeHeight: aBoolean [

	uniformNodeHeight := aBoolean
]

{ #category : #'t - basic finite list element configuration - accessing' }
TToBasicListElementConfiguration >> uniformNodeWidth [

	^ uniformNodeWidth ifNil: [ uniformNodeWidth := false ] 
]

{ #category : #'t - basic finite list element configuration - accessing' }
TToBasicListElementConfiguration >> uniformNodeWidth: aBoolean [

	uniformNodeWidth := aBoolean
]

{ #category : #accessing }
TToBasicListElementConfiguration >> useCheckbox [ 

	^ useCheckbox 
]

{ #category : #accessing }
TToBasicListElementConfiguration >> useCheckbox: aBoolean [

	useCheckbox := aBoolean
]
