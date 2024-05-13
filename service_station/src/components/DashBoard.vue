<template>
    <h1>Dashboard</h1>
    <div class="item">

        <iframe src="https://embed.domo.com/cards/mQmNE" width="1000px" height="300" marginheight="0" marginwidth="0"
            frameborder="0"></iframe>
    </div>
    <div class="chart2">
        <div class="item">
            <iframe src="https://embed.domo.com/cards/wmNY8" width="500" height="440" marginheight="0" marginwidth="0"
                frameborder="0"></iframe>
        </div>
    </div>


    <div class="chart3">
        <div class="item">
            <iframe src="https://embed.domo.com/cards/xvALz" width="500" height="780" marginheight="0" marginwidth="0"
                frameborder="0"></iframe>
        </div>
    </div>

    <div class="chart4">
        <div class="item">
            <iframe src="https://embed.domo.com/cards/MQPWP" width="470" height="440" marginheight="0" marginwidth="0"
                frameborder="0"></iframe>
        </div>
    </div>




</template>

<style scoped>

h1 {
    color: #333;
}

.chart2 {
    position: absolute;
    top: 435px;
    left: 40px;
}
.chart4 {
    position: absolute;
    top: 435px;
    right: 770px;
}

.chart3 {
    position: absolute;
    top: 95px;
    right: 240px;
}

.item {
    width: fit-content;
    background-color: #ffffff;
    border: 1px solid #f0c0cb;
    border-radius: 10px;
    padding: 10px;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
}
</style>

<script>
export default {
    data() {
        return {
        };
    },
    mounted() {
    },
    methods: {
    }
}
</script>